# Codeship SSH Helper Image

This is a helper image to make it easier to use SSH keys on Codeship Pro. It allows you to easily generate a new SSH keypair, create the (unencrypted) environment file and to write the key to a file again during your Codeship Pro build.

## Build Locally

To build the image locally, clone the repository and run the following command from within your local COPY

```shell
docker build -t codeship/ssh-helper .
```

At a later point we will make the image available via Docker Hub as well.

## Generate a New SSH KEY

The following command will create a new SSH key and write the files to your current directory. The filenames will be `codeship_deploy_key` for the private key and `codeship_deploy_key.pub` for the public one.

```shell
docker run -it --rm -v $(pwd):/keys/ codeship/ssh-helper generate "<YOUR_EMAIL>"
```

Your email address is added to the key via the comment to make it easier to know who created the key.

Also, the tool is fairly opionated and won't let you change any parameters of the key, or the file the key is written to yet. All other commands rely on those files as well, so it's not advisable to rename the files yourself.

As for the generated keys, those are 4096 bit RSA keys without a passphrase. So make sure the private key is never committed to the repository or shared with somebody who you don't want to have access to your resources.

## Prepare the Environment File

The following command will take the private key (named `codeship_deploy_key`) and format it in a way to be passed to a Codeship Pro build (or the `jet` CLI) as an environment variable. It is highly recommend to **encrypt that value via `jet encrypt`**.

```shell
docker run -it --rm -v $(pwd):/keys/ codeship/ssh-helper prepare
```

The resulting file will be called `codeship.env`, and the value will be appended if that file already exists.

## Write the Environment Variable Back to a File

During your Codeship Pro builds, you need to take the environment variable and write it back to a file, to pass to the `ssh` (or similar) commands.

```shell
docker run -it --rm -v $(pwd):/keys/ --env-file codeship.env codeship/ssh-helper write
```

This is a way to test the functionality locally. It will take the environment file from the _Prepare_ step and use that to write the private SSH key to a file called `id_rsa`. You can check that this is indeed the same key generated in the _Generate_ step by running `diff ./.ssh/id_rsa	./codeship_deploy_key`.

During a regular Codeship Pro build you would run a step at the very beginning of your build to write the file to a volume and then mount that volume in later steps that require access to the private key. This would look similar to the following snippets

```yaml
# codeship-services.yml
ssh:
  image: codeship/ssh-helper
  encrypted_env_file: codeship.env.encrypted
  volumes:
    - ./:/keys/
deployment:
  image: codeship/ssh-helper
  volumes:
    - .ssh:/root/.ssh
    - .:/app
```

```yaml
# codeship-steps.yml
- name: Write Private SSH Key
  service: ssh
  command: write
- name: Copy Files
  service: deployment
  command: scp -r /app/ user@myserver.com:app/
- name: Restart Server
  service: deployment
  command: ssh user@myserver.com restart_server
```

# Contributing

We are happy to hear your feedback. Please read our [contributing guidelines](CONTRIBUTING.md) and the [code of conduct](CODE_OF_CONDUCT.md) before you submit a pull request or open a ticket.

# License

see [LICENSE](LICENSE)

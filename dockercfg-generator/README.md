# dockercfg Generator

This container allows you to generate a dockercfg using your username and password for any registry compatible with running `docker login` and writes it to a specified filename. Typical usage of this image would be to run it with a volume attached, and write the dockercfg to that volume.

## Local Usage

Add the required credentials (username, password and an optional registry URL) to a file on your computer, e.g. called `credentials.env`.

```
DOCKER_USERNAME=...
DOCKER_PASSWORD=...
DOCKER_REGISTRY=https://index.docker.io/v1/
```

Use the published image to create the `dockercfg` file.

```shell
docker run -it --rm \
	--env-file=credentials.env \
	-v "$(pwd):/opt/data/" \
	-v "/var/run/docker.sock:/var/run/docker.sock" \
	codeship/dockercfg-generator /opt/data/dockercfg
```

Running the above command will create a `dockercfg` file in your current directory, that you can use via the `encrypted_dockercfg_path` directive on Codeship Pro.

## Using via `dockercfg_service`

Same as above, add the required configuration values to a local credentials file and [encrypt it using `jet encrypt`](https://codeship.com/documentation/docker/encryption/). Then define a `dockercfg_service` in your `codeship-services.yml` file that references the encrypted environment variable file.

```
dockercfg_test_generator:
  image: codeship/dockercfg-generator
  add_docker: true
  encrypted_env_file: docker.env.encrypted
```

On the `push` step, reference the above service

```
- name: Test dockercfg Generator
  service: dockercfg_test
  type: push
  image_name: codeshipdeploy/codeship-testing
  dockercfg_service: dockercfg_test_generator
```

You can see a working example of this setup in the [codeship-services.yml](codeship-services.yml) and [codeship-steps.yml](codeship-steps.yml) files included in this repository.

# Contributing

We are happy to hear your feedback. Please read our [contributing guidelines](CONTRIBUTING.md) and the [code of conduct](CODE_OF_CONDUCT.md) before you submit a pull request or open a ticket.

# License

see [LICENSE](LICENSE)

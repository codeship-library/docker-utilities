# Generic Docker related images for Codeship Pro

## dockercfg Generator

This container allows you to generate a dockercfg using your username and password for any registry compatible with running `docker login` and writes it to a specified filename. Typical usage of this image would be to run it with a volume attached, and write the dockercfg to that volume.

See the [dockercfg Generator Readme](dockercfg-generator/README.md) for detailed usage instructions.

## SSH Helper

Working with SSH keys in Codeship Pro is more involved than on Codeship Basic. To help handle injecting keys into your containers while running a build, as well as preparing the required files, we built a helper image.

See the [SSH Helper Readme](ssh-helper/README.md) for more information and usage details.

## Contributing

We are happy to hear your feedback. Please read our [contributing guidelines](CONTRIBUTING.md) and the [code of conduct](CODE_OF_CONDUCT.md) before you submit a pull request or open a ticket.

## License

see [LICENSE](LICENSE)

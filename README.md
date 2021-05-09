<div align="center">

# asdf-age ![Build](https://github.com/threkk/asdf-age/workflows/Build/badge.svg) ![Lint](https://github.com/threkk/asdf-age/workflows/Lint/badge.svg)

[age](https://age-encryption.org/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Issues](#issues)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add age
# or
asdf plugin add age https://github.com/threkk/asdf-age.git
```

age:

```shell
# Show all installable versions
asdf list-all age

# Install specific version
asdf install age latest

# Set a version globally (on your ~/.tool-versions file)
asdf global age latest

# Now age commands are available
age --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Issues

Issues related to age should be reported at its [Github repository](https://github.com/FiloSottile/age/issues). Issues related with the installation of age using asdf should be reported [here](https://github.com/threkk/asdf-age/issues).

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/threkk/asdf-age/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Alberto de Murga](https://github.com/threkk/)

# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test age https://github.com/threkk/asdf-age.git "age --help"
```

Tests are automatically run in GitHub Actions on push and PR.

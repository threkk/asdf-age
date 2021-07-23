#!/usr/bin/env bash

set -euo pipefail

REPORT_URL="https://github.com/threkk/asdf-age/issues"
GH_REPO="https://github.com/FiloSottile/age"
TOOL_NAME="age"
TOOL_TEST="age --help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if age is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

latest_version() {
  local query
  query="$1"
  [ -z "$query" ] && query="[0-9]"
  list_all_versions | sort_versions | grep "$query" | tail -n 1
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  case $(uname | tr '[:upper:]' '[:lower:]') in
    linux*)
      local platform="linux-amd64.tar.gz"
      ;;
    darwin*)
      local platform="darwin-amd64.tar.gz"
      ;;
    *)
      fail "Platform download not supported. Please, open an issue at $REPORT_URL"
      ;;
  esac

  url="$GH_REPO/releases/download/v${version}/${TOOL_NAME}-v${version}-${platform}"

  echo "* Downloading $TOOL_NAME release $version from $url"
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path/bin"
    chmod +x "$install_path/bin/$TOOL_NAME"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}

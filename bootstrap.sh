#!/bin/bash -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function prompt() {
  echo -n "*** I'm just about to $1 - is that okay? ([y]es, [n]o or [s]kip) > "
  read ANSWER
  if [ "$(echo "$ANSWER" | grep -ic '^y$')" -eq 1 ]; then
    echo '*** Proceeding...' >&2
    true
  elif [ "$(echo "$ANSWER" | grep -ic '^s$')" -eq 1 ]; then
    echo '*** Skipping...' >&2
    false
  else
    echo '*** Bailing...' >&2
    exit 99
  fi
}

function installNodeMac() {
  if prompt "install Node on your OS X box with Homebrew"; then
    set +e
      HOMEBREW=$(which brew)
      HOMEBREW_CODE=$?
    set -e
    if [ "$HOMEBREW_CODE" -gt 0 ]; then
      echo "*** Homebrew is not installed; visit http://brew.sh/"
      exit 1
    fi
    # Check the install version first
    NODE_VERSION_LINE=$($HOMEBREW info node | head -n 1)
    if [ "$(echo "$NODE_VERSION_LINE" | grep -c "stable $NODE_VERSION_REGEX")" -eq 0 ]; then
      echo -e "\nCan't find a version of Node available on Homebrew matching ${NODE_VERSION_REGEX} - you may need to update your local formula cache by running:\n  brew update\n"
      exit 1
    fi
    "$HOMEBREW" install node
  fi
}

function installNodeRH() {
  if prompt "install Node on your RedHat box with a 'curl -sL https://rpm.nodesource.com/setup_5.x | sudo -E bash -'"; then
    set -x
      curl -sL https://rpm.nodesource.com/setup_5.x | sudo -E bash -
      sudo yum install -y nodejs
    set +x
  fi
}

function installNodeDebian() {
  if prompt "install Node on your Debian/Ubuntu box with a 'curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -'"; then
    set -x
      curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
      sudo apt-get install -y nodejs
    set +x
  fi
}

# Node
set +e
  NODE=$(which node)
  NODE_CODE=$?
  export NODE_VERSION_REGEX='[456]\.'
set -e

if [ "$NODE_CODE" -eq 0 ]; then
  NODE_VERSION=$("$NODE" --version)
  if [ "$(echo "$NODE_VERSION" | grep -c "^v${NODE_VERSION_REGEX}")" -eq 1 ]; then
    echo "*** Node.js ${NODE_VERSION} already installed."
  else
    echo "*** Node.js already installed, but expected version matching ${NODE_VERSION_REGEX} - found ${NODE_VERSION} instead."
    exit 1
  fi
else
  # Node bootstrapping
  SCRIPT_DIR=$(dirname "$0")
  if [ "$(uname -a | grep -ci Darwin)" -gt 0 ]; then
    installNodeMac
  elif [ -f "/etc/debian_version" ]; then
    installNodeDebian
  elif [ -f "/etc/redhat-release" ]; then
    installNodeRH
  else
    echo "*** I don't know how to bootstrap Node 4+ for this platform; have a look at https://github.com/nodesource/distributions for more options"
    exit 1
  fi
fi

# npm
# Upgrade npm? (npm v2 is bundled with Node, so we can at least rely on it existing.)
NPM_VERSION=$(npm --version)
if [ "$(echo "$NPM_VERSION" | grep -c '^3\.')" -eq 1 ]; then
  echo "*** npm ${NPM_VERSION} already installed."
else
  if prompt "install npm v3+ globally with 'npm install -g npm@3'"; then
    npm install -g npm@3 # 3+, eg. 3.5.1
  fi
fi

if [ "$(echo "$PATH" | grep -c 'node_modules/\.bin')" -eq 0 ]; then
  export PATH="$PATH:node_modules/.bin"
  if prompt 'add a PATH entry (PATH="$PATH:node_modules/.bin") to your .bashrc'; then
    echo ';export PATH="$PATH:node_modules/.bin"' >> ~/.bashrc
  fi
fi

if prompt "npm install, bower install and generate devdocs for the exercise dependencies"; then
  pushd "common/console"
    bower install
    npm install
    for DIR in ../../0{1,2}*/*/*s*; do
      cp -a node_modules "${DIR}/"
    done
    "${SCRIPT_DIR}/devdocs.sh"
  popd

  pushd "common/web"
    bower install
    npm install
    for DIR in ../../0{3,4}*/*/*s*; do
      cp -a node_modules "${DIR}/"
    done
    "${SCRIPT_DIR}/devdocs.sh"
  popd
fi

# npm run build
if prompt "attempt builds for every exercise directory"; then
  for DIR in Exercise Answer; do
    find . -type d -name "$DIR" -exec sh -c 'cd "{}" && echo "+++ {} +++" && npm run -s build' \;
  done
fi

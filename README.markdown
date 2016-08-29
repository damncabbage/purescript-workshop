PureScript Workshop Exercises
=============================

This is a set of exercises for [YOW! Lamba Jam 2016](http://lambdajam.yowconference.com.au)'s PureScript workshop: _A Whirlwind Tour of PureScript_.


## Setup

[Context: This workshop was meant to be tackled from inside a virtual machine (Virtualbox w/ an OVA). A bootstrap script was also provided in case people wanted to set up PureScript on their own machines.]

To get started:

1. Clone this git repo to somewhere local on your machine,
2. Run the bootstrap setup script (with `./bootstrap.sh`, from inside the checked-out workshop directory).
   This script will:
   * Check and install any tools you need (Node, npm, PureScript / pcs, Pulp, purescript-psa, pscid), and
   * Run a `bower install`, `npm install` and an `npm run -s build` on every exercise, to prepare
     the exercises for you in advance (eg. if you're only connected to the 'net for a short while).

It's recommended that you use an editor with some PureScript integration. I recommend
[Atom](https://atom.io/) set up with the [atom-ide-purescript](https://github.com/nwolverson/atom-ide-purescript)
plugin, opening each exercise as a separate project. Alternatively, [pscid](https://github.com/kRITZCREEK/pscid) is
an alternative that can be used as a file-watch + fast-rebuild tool with any editor.


## Exercises

The exercises are broken up into sections and sub-sections, with each having its own README, Exercise
and Answer folders. Every Exercise and Answer is an independent program that can be interacted with
in the following way:

* **Build:** `npm run -S build` in an Exercise or Answer directory will rebuild that program and
  display errors and warnings. If you're using the VM with the Atom editor, this is being run for
  you on every save.
* **Test:** `npm run -S test` will run any tests defined.
* **Interactive Console Tool (REPL):** `npm run repl` will kick off `pulp psci`, an interactive command-line tool (like GHCI,
  `irb`, or `node` or `python` without arguments). Hit Ctrl-C to quit.
* **Server:** Some later exercises have a web-based component; `npm run -S start` will start the
  Webpack+Express dev server, which also provides hot-reloading for quick feedback. Hit Ctrl-C to
  stop it.


## How Do I Start?

Open up the `01 Basics` folder, then the first `01 Building Things, Finding Things...` folder, and
then read and follow the instructions from the README.markdown file within.


## Topic Outline

* 01 Basics
  * 01 Building Things, Finding Things, Trying Things
  * 02 Here's One We Messed Up Earlier
  * 03 Types and Patterns
  * 04 Maybe it's Just Nothing

* 02 Rows and Effects
  * 01 Places to Be
  * 02 Things to Do
  * 03 Composing Effects

* 03 Web with Pux
  * 01 States and Views
  * 02 Actions and Updates
  * 03 Effectful Updates
  * 04 Skynet

* 04 FFI Playground



## License

Copyright 2016 Rob Howard

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.

PureScript Workshop Exercises
=============================

This is a set of exercises for [YOW! Lamba Jam 2016](http://lambdajam.yowconference.com.au)'s and
[Compose Melbourne 2016](http://www.composeconference.org/2016-melbourne/unconference/)'s PureScript
workshop: _A Whirlwind Tour of PureScript_.


## Setup

This repository has a bootstrap script, which downloads a small pile of things and sets things up for you. To get this going:

1. Clone this git repo to somewhere local on your machine (eg. with `git clone https://github.com/damncabbage/purescript-workshop workshop`)
2. Run the bootstrap setup script (with `./bootstrap.sh`, from inside the checked-out workshop directory).
3. Put an issue in this repo if you get stuck.

It's helpful to use an editor with some PureScript integration. I recommend [Atom](https://atom.io/)
set up with the [atom-ide-purescript](https://github.com/nwolverson/atom-ide-purescript) plugin,
opening each exercise as a separate project. Alternatively,
[pscid](https://github.com/kRITZCREEK/pscid) is an alternative that can be used as a file-watch +
fast-rebuild tool with any editor.

[Author's notes: This set of exercises uses an oldish version of PureScript (0.9.3). This sounds bad,
but the exercises themselves won't really be affected by the language upgrades; it's all
behind-the-scenes stuff. All the same, I'll be looking at upgrading this repo shortly to both
PureScript 0.10.x and the new release of Pux.]


## Exercises

The exercises are broken up into sections and sub-sections, with each having its own README, Exercise
and Answer folders. Every Exercise and Answer is an independent program that can be interacted with
in the following way:

* **Build:** `npm run -s build` in an Exercise or Answer directory will rebuild that program and
  display errors and warnings. If you're using the VM with the Atom editor, this is being run for
  you on every save.
* **Interactive Console Tool (REPL):** `npm run -s repl` will kick off `pulp psci`, an interactive command-line tool (like GHCI,
  `irb`, or `node` or `python` without arguments). Hit Ctrl-C to quit.
* **Server:** Some later exercises have a web-based component; `npm run -s start` will start the
  Webpack+Express dev server, which also provides hot-reloading for quick feedback. Hit Ctrl-C to
  stop it.

Additionally, there are a pile of generated API docs in Markdown format in each exercise's folder,
under `devdocs/...`.


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

* 04 FFI
  * 99 Playground



## License

Copyright 2016 Rob Howard

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.

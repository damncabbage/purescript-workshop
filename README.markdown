PureScript Workshop Exercises
=============================

This is a set of exercises for [YOW! Lamba Jam 2016](http://lambdajam.yowconference.com.au)'s PureScript workshop: _A Whirlwind Tour of PureScript_.


## Setup

Before starting:

* If you are reading this from inside the Workshop VM, everything is set up and ready to go; this
  file should be sitting in a `workshop` folder off the home directory.

* If you've chosen to set this up independently, clone this git repo to somewhere local on your
  machine, and run the bootstrap setup script that will:
  1. Check and install any tools you need (Node, npm, PureScript / pcs, Pulp, purescript-psa, pscid), and
  2. Run a `bower install`, `npm install` and an `npm run -s build` on every exercise, to prepare
     the exercises for you in advance (eg. if you're only connected to the 'net for a short while).

It's recommended that you use an editor with some PureScript integration. The VM has
[Atom](https://atom.io/) set up with the [atom-ide-purescript](https://github.com/nwolverson/atom-ide-purescript)
plugin installed. Alternatively, [pscid](https://github.com/kRITZCREEK/pscid) is already installed
and can be used as a file-watch + fast-rebuild tool with any editor.


## Exercises

The exercises are broken up into sections and sub-sections, with each having its own README, Exercise
and Answer folders. Every Exercise and Answer is an independent program that can be interacted with
in the following way:

* **Build:** `npm run build` in an Exercise or Answer directory will rebuild that program and
  display errors and warnings.
* **Test:** `npm run test` will run any tests defined.
* **REPL:** `npm run repl` will kick off `pulp psci`, an interactive command-line tool (like GHCI,
  `irb`, or `node` or `python` without arguments). Hit Ctrl-C to quit.
* **Server:** Some later exercises have a web-based component; `npm run start` will start the
  Webpack+Express dev server, which also provides hot-reloading for quick feedback. Hit Ctrl-C to
  stop it.


## Topic Outline

* 01 Basics
  * 01 Building Things, Finding Things, Trying Things
  * 02 Here's One We Messed Up Earlier
  * 03 Types and Patterns
  * 04 Maybe Just Nothing
  * 05 Type Classes and Instances

* 02 Rows and Effects
  * 01 Places to Be
  * 02 Things to Do
  * 03 Composing Effects

* 03 Web with Pux
  * 01 States and Views
  * 02 Actions and Updates
  * 03 Effectful Updates

* 04 JavaScript from PureScript (FFI)
  * 01 One Plus One
  * 02 Backwards Map
  * 03 Effectful FFI
  * 04 Effectful Kinds
  * 05 Foreign Types
  * 06 isNothing, Maybe isJust

* 05 PureScript from JavaScript
  * 01 Two Plus Two
  * 02 Uncurried Addition

* 08 Testing
  * 01 Basic Assertions
  * 02 Simple Properties

* 07 Asynchronicity
  * ...


## License

Copyright 2016 Rob Howard

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.

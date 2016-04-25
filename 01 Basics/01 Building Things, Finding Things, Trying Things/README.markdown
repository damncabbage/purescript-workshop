# Building Things, Finding Things, Trying Things

## Goal

To get you familiar with what PureScript code looks like, how to build it, and how to muck
around with the interactive command-line tool (AKA a "REPL"), psci.

(This one is mostly a read-only excursion.)


## Exercise

In the Exercise folder, there are six folders:

* `bower_components`: PureScript uses [Bower](http://bower.io/) as its package manager (but only
  for PureScript dependencies). Defined by `bower.json`, when we run `bower install`, Bower puts
  the dependencies here.

* `node_modules`: PureScript also can use [npm](https://www.npmjs.com/); any JS dependencies
  installed with it will appear in this folder.

* `src`: The source files live here; in this case, there's only one file (`Main.purs`), but there
  can be subdirectories and files under here, each defining a PureScript module.

* `test`: The test source files live here; same deal as `src`.

* `output`: The compiled JS output lives here, in top-level directories, one per PureScript module,
  eg. `output/MyApp.Game.Missile/...`. This can be the end result that's used directly, or it can
  optionally be _bundled_ with `psc-bundle` into a single file, with have dead-code elimination and
  other optimisations done in the process of making it.

* `devdocs`: This is a folder of auto-generated API docs made with the `devdocs.sh` script in the root.
  It's non-standard; usual practice is to look libraries up on [Pursuit](http://pursuit.purescript.org/),
  but we don't have 'net access in here. :-)


Now let's try some things:

* Start your editor in the Exercise directory, eg. with a terminal, `cd Exercise` then `atom .`

* Have a look at `src/Main.purs`; it's heavily-commented, so have a read through and ask a
  helper if you don't understand anything.

* Build the project with `npm run build` and check the output. Have a look in `output/`,
  particularly `output/Main/index.js` to see what the compiled JavaScript looks like, and how it pulls
  in dependencies from other compiled files.

* (Optional) If you're curious, run `npm run bundle` to produce a compiled bundle with dead-code
  elimination run over it in `output/bundle.js`.

* Open up the command-line interface with `npm run repl`. Run this first line to make the functions
  in Main available to you:  
  ```
  > import Main
  ```  
  ... Then try some of the following:  
  ```
  > :browse Main
  > alwaysYes
  > sometimesYes 0
  > occasionallyYes 2 3
  > palindromicYes "rats"
  > palindromicArray [1,2,3]
  > palindromicForAllArray ["Man","Plan","Man"]
  ```

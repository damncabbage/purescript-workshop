# States and Views

## Goals

To see how one of the PureScript UI frameworks, Pux, models UI rendering as a function of State ->
HTML.

## Background

UIs with Pux are modelled in terms of four things:

* State (including an Initial State, init)
* Actions (a type representing different UI actions you can take)
* An update function (to interpret an Action and return a new State)
* A view function (taking the State and producing HTML).

This is likely very familiar to you if you've at all used Elm; this more or less lines up with the
"Elm Architecture", and is intentionally built this way.

This exercise is just going to cover State, initial state, and the view part of this.


## Setup

The setup for this is going to be a little different to the others. We're going to use a small dev
web-server to run the code for this project, and leave it running in the background.

Open up your terminal and change to the Exercise directory, then run:
```
npm run start
```

This will kick off something that will stay running in that terminal until you end it with Ctrl-C.
It will give you a webserver that you can access at http://localhost:3000/ - if you're using the VM,
you can open Chromium from the desktop and it will navigate there by default.

Additionally! If you save, then it will do its best effort to update things in place (keeping any
state).


## Exercises

* Open up `src/Play.purs` and follow the instructions.


## Additional Information

There are other UI frameworks if you want to check them out at a later time:
* Thermite (another type-safe wrapper over React)
* Halogen (Slamdata's UI framework; more complicated, but allowing for less boilerplatey composition
  and local component state)
* Optic-UI (UI composition with lenses)
* Flare (an automatic UI builder)


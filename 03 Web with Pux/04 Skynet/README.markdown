# Skynet

## Goals

To usher in a new era of Rock-Paper-Scissors AI bots.

## Background

We're jumping ahead to the future a bit. We have a full Rock Paper Scissors game made, and as part
of that we have a computer player, `App.Play.randomAI`, which just plays random Hand choices.

We want to do better; each bot has access to previous pairs of hands (`Round`), and is allowed to
use the `random :: RANDOM` effect. Go nuts. :-)


## Exercises

* As before, change to the Exercise directory and run `npm run start` in a terminal, and visit
http://localhost:3000/ in a web browser.

* Open up `src/Game.purs` and have a read of the instructions.

* Optional: open up `src/Play.purs` and have a look around a more complete game example.

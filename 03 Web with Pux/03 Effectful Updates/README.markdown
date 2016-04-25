# Actions and Updates

## Goals

To see how Pux models *effectful* changes to state.

## Background

Much like back in the "Rows and Effects" exercises, everything you've seen so far of the Pux UI has
been modelling pure changes to state. That's all well and good, but sometimes we need to make an
AJAX call, use a random number generator, get the current time, or something else that involves the
outside world.

We're going to be focusing on changing the `update` function to support effects. The old
signature:
```
update :: Action -> State -> State
```

The new one:
```
update :: forall eff. Action -> State -> EffModel State Action (...effects... | eff)
```

EffModel is just a Type Alias for this row type:
```
type EffModel state action eff =
  { state :: state
  , effects :: Array (Aff (channel :: CHANNEL | eff) action)
  }
```

This is going to be a bit tough to put together with what you know so far, but here's what's going
on. We have:

* An Object with `state` and `effects` fields.
* A State matching the State earlier in the type signature; this is going to refer to your component's
  State type.
* A list of potential asynchronous effects (`Aff`), including a Signal Channel (we're going to
  hand-wave this), returning your component's Action type.


On this `Aff` thing (as opposed to `Eff`):

* For the Haskellers in the room, the `Aff` is the combination of an ErrorT transformer with ContT;
  as per the [purescript-aff docs](https://github.com/slamdata/purescript-aff), it's morally
  `ErrorT (ContT Unit (Eff e) a`, for effects `e`. In this particular case `a` is the
  component's Action.
* For the JS devs, `Aff` is a way of stringing together asynchronous actions in a way that looks
  like sequential actions, a little like Promises but with the benefit of enforced error handling.


We can dig into this a little more separately; both the
[Aff](https://github.com/slamdata/purescript-aff) and
[Pux](http://www.alexmingoia.com/purescript-pux/docs/fetching-data.html) docs are a good place to
start; there's a copy of both repos in the Examples folder on your VM or USB key.


In any case, an example use of an update function that evaluates an Aff asynchronous function and
an Eff synchronous function, and returns an Action to process looks like:
```
update :: forall eff. Action -> State
       -> EffModel State Action (... | eff)
update FetchSomething state =
  -- Effectful
  { state: state
  , effects: [
      do
        x <- someAsyncAffThing          -- Aff functions are fine as-is.
        y <- liftEff (someSyncEffThing) -- Eff functions need a liftEff.
        pure (DoSomething (x <> y))
    ]
  }

update (DoSomething x) state =
  -- Pure.
  noEffects (state { stringThing = x })
```


## Exercises

* As per the other Pux examples, `npm run start` in a terminal, and open `src/Play.purs` in your
editor.

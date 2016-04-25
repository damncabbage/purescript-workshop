# Actions and Updates

## Goals

To understand how Pux models pure changes to state.


## Background

As before, UIs with Pux are made up of:

* State (including an Initial State, init)
* Actions (a type representing different UI actions you can take)
* An update function (to interpret an Action and return a new State)
* A view function (taking the State and producing HTML).

We're going to be focusing on Actions, and their corresponding update function.

This is an action / update pair:
```
data Action = Increment
            | Decrement

update :: State -> Action -> State
update Increment state = ...
update Decrement state = ...
```

The next thing we're going to do is set up a way for a user to trigger an action. Each HTML element
in the view is made up of a couple of things:
```
-- button <attributes> <child-nodes>
-- eg.
   button [ className "example-css-class" ]
          [ text "A child text-node" ]

-- ... Producing:
-- <button class="example-css-class">A child text-node</button>
--
-- For reference:
-- button :: forall a. Array (Attribute a) -> Array (Html a) -> Html a

```

Among other attributes, there are also Event triggers, such as `onClick`:
```
button [ onClick (\event -> Increment) ] [ text "button text" ]

-- ... Producing a button that, when clicked, triggers the Increment action.
--
-- For reference:
-- onClick :: forall action. (MouseEvent -> action) -> Attribute action
```

When triggering an event:
* The resulting Action is used (with the current state) by the `update` function to produce a
  new State.
* Then, as you saw in the previous exercise, that State is then used by `view` to produce HTML.


(There is another way of triggering an update, but we'll be covering that in the next exercise.)


## Exercises

* As before, change to the Exercise directory and run `npm run start` in a terminal, and visit
http://localhost:3000/ in a web browser.

* Open up `src/Play.purs` and follow the instructions.

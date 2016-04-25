# Types and Patterns

## Goal

To introduce you to types outside the regular String, Int, Boolean and so on, and to make of these
new types.


## Background

### Defining Types

You've previously seen String, Int, etc. show up in functions' *type signatures*. For example:

```
addsOne :: Int -> Int
```

Int is one of the built-in types. You can define your own too.

This is a type declaration. Let's pretend we've defined the Type "Int" ourselves:

```
data Int = 0 | 1 | 2 | 3 | ...
```

On the left of the "=" we have a type, and on the right we have some "data constructors" (ways of
making a value of that type). In this case, the constructors are a big pile of whole numbers.

(Ints aren't actually defined like this; it's just a way of thinking about it.)

So back to `addsOne`:

```
addsOne :: Int -> Int
addsOne x = x + 1
```

That `1` shows up on the right-hand side of the pretend Int type declaration above. By using this
constructor, you've created a value of type Int.

Let's define our own type, a real one this time:

```
data TrafficLight = Red | Yellow | Green
-- (Types and Constructors always start with a capital letter.)
```

(An aside: Types and Constructors aren't part of the same namespace; it's perfectly fine to have a
`data Foo = Foo`. As one can only be used in the type declarations and the other only ever in the
function body, there's no crossover.)


### Matching Types

Previous we've seen function bodies take named arguments, like this:
```
isZero x = x + 1
```

We can use something called "pattern matching" to check that an argument matches a certain
constructor, eg.
```
isZero 0 = true   -- Match on a case (a constructor).
isZero x = false  -- Anything else is false.
```

It's a little like a `switch` or `case` statement, and is handy to match on a bunch of options
instead of using the == equality-comparison function.


## Exercise

We're going to start making a Rock Paper Scissors game. Open up `src/Main.purs`:

* Have a read of what's there; it's a short summary of the features introduced above.

* Fill out two custom types: "Hand" (the choice of Rock, Paper, etc) and "Result" (the three
  possible game results).

* Write a function, taking two Hands and returning one Result, the determines the winner of a given
  play. A type-signature is provided for you.

* As you go, feel free to experiment with `npm run psci` (using `import Main`) to try out your
  function. When you're done, you should be able to run the following:  
  ```
  > winner Rock Scissors
  Main.P1Won
  > winner Paper Paper
  Main.Draw
  ```


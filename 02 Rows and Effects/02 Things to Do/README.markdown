# Things to Do

## Goal

Introducing Effect Typing, both the idea of "pure" vs "effectful" functions, as well as using the
Row Types to control the kinds of allowed effects.


## Background

### Pure vs Effectful

Everything you've seen until now have been "pure" functions; the output is entirely dependent on the
input you give it, it doesn't affect anything else by calling it, and no matter how many times you
evaluate it with the same input, the output will never change.

This function, for example, is pure:
```
one = 1
```

As is:
```
add a b = a + b
```

Using Control.Monad.Eff.Console's "log" method, though, isn't. It prints some value to either the
process' standard output or the web-browser's console, and when it's evaluated it changes the state
of both (adding more data).

And neither is Control.Monad.Eff.Random's "randomInt". It *depends* on the system or web-browser's
random number generater, and in calling it you also *changes* that number generator (eg. moving the
seed on).

The core idea in all this is something called "referential transparency", and is a core property of
functional programming. We have this transparency, and our program is more predictable as a result,
if something like this:
```
list  = [3,1,4,2]
evens = filterEvens(sort(list))
odds  = filterOdds(sort(list))
```

... Is equivalent to this:
```
list  = sort([3,1,4,2])
evens = filterEvens(list)
odds  = filterOdds(list)
```


### Eff and Row Types

We indicate effectful functions in PureScript with a type called `Eff`.

(For the Haskellers in the audience, the type and kind of Eff is: `# ! -> * -> *`)

Eff is made up of a Row Type (labels with types) and a type to return. For example, this function
has a type indicating that it interacts with the random number generator, and returns a number:
```
someRandomInt :: Eff (random :: RANDOM) Int
```

Like any other function, these effectful functions can also take input parameters, eg.
```
logToConsole :: String -> Eff (console :: CONSOLE) Unit
```

(Why Unit? It's a type that has only one constructor or "inhabitant"; if you were to define it
yourself, it'd look like: `data Unit = Unit`. We use it here to indicate that the Eff will return
nothing useful. NOTE: This isn't a Null or Undefined like how you're used to in other languages;
it's a completely separate type in its own right, and can't be mixed in with Int or String or
whatever.)


### Using values

There is a very long explanation for this involving Functors, Applicatives and Monads, which is
frankly explained better by a lot of other material, and is basically an entire workshop in itself.
After this workshop, I highly recommend going and finding the [Haskell Book](http://haskellbook.com)
(a sample of which is on the USB key) and learning this properly from the ground up.

For now, though, here's the monkey-see monkey-do version of three things: do, <- and pure.

Say we have a function with returning an Effectful computation, involving the RANDOM effect, and
returning an integer:
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = ...
```

First thing we need to do is the first random number. This uses an Eff (..) Int function, randomInt,
and assigns the result to "first".
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = do   --  <== This "do" lets us join some of these Eff computations together; it's
                     --      called "do notation", and is an easier-to-read version of something
                     --      else called ">>=" or "bind".
  first <- randomInt 0 999  -- randomInt is: Int -> Int -> Eff (..) Int
                            -- first is: Int
  ...
```

With "first" being an Int, we can now use it as the input to another function, or otherwise used
later:
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = do 
  first  <- randomInt 0 999    -- randomInt is: Int -> Int -> Eff (..) Int, first is: Int
  second <- randomInt 0 first  -- We use first, an Int, as part of an input to randomInt.
  ...
```

A word of warning! This is *wrong*:
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = do 
  first  <- randomInt 0 999
  second <- randomInt 0 first
  first + second  -- <== This bit.
```

first and second are both `Int`. The return value of this function is `Eff (random :: RANDOM) Int`.
Here, we can use something called "pure" to turn the value into an `Eff (random :: RANDOM)` value.

This works:
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = do 
  first  <- randomInt 0 999
  second <- randomInt 0 first
  pure (first + second)
```

So does this:
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = do 
  zero   <- pure 0
  first  <- randomInt zero 999
  second <- randomInt zero first
  pure (first + second)
```

And lastly, so does this:
```
randomNumbers :: Eff (random :: RANDOM) Int
randomNumbers = do 
  let zero = 0
  first  <- randomInt zero 999
  second <- randomInt zero first
  pure (first + second)
```

That's `do`, `<-` and `pure`. For now. :-)


## Exercise

* Open up `src/Main.purs` and follow the instructions.

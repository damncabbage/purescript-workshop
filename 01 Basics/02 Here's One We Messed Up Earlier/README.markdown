# Here's One We Messed Up Earlier

## Goal

To introduce things going wrong: you're going to see a compiler error, and then you're going to fix
the problem that it's telling you about.


## Exercise

Go to the Exercise folder and run `npm run build`. You should see something that looks like this:

```
* Building project in .../01 Basics/02 Here's One We Messed Up Earlier/Exercise
[1/1 TypesDoNotUnify] src/Main.purs:9:28

  9  multipliesAndAddsOne x y = addsOne (x * y)
                                ^^^^^^^^^^^^^^

  Could not match type

    Int

  with type

    String

  while checking that type Int
    is at least as general as type String
  while checking that expression addsOne (((*) x) y)
    has type String
  in value declaration multipliesAndAddsOne
```

Open up `src/Main.purs` in your editor, and:

* Try to figure out what the problem is, then
* Fix it, and
* Run the build again.

If you get stuck, ask for help, or have a peek at the Answer folder.

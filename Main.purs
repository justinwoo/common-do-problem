module Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)

getMsg :: Effect String
getMsg = pure "hi"

-- "Why do I get weird errors with do blocks?"
main :: Effect Unit
main = do -- do block for Effect
  msg <- getMsg -- pull out `thing` from `Effect thing`
  log msg

  msg2 <- pure "bye" -- first, take String, then put it into Effect
                     -- i.e., pure ::    a   ->   f      a
                     --       pure :: String -> Effect String
                     -- then, pull out the `String` from `Effect String`
  log msg2

  -- example error:
  -- msg3 <- "yes"
  --
  -- This gives this error:
  --   Could not match type
  --     String
  --   with type
  --     t0 t1
  --
  -- while checking that type String
  --   is at least as general as type t0 t1
  -- while checking that expression "bye"
  --   has type t0 t1
  -- in value declaration main
  --
  -- where t0 is an unknown type
  --       t1 is an unknown type
  --  [TypesDoNotUnify]
  --
  -- What was meant instead:
  let msg3 = "yes"
  log msg3

  -- Why does this happen?
  -- remember above, we pulled out things from Effect
  -- the compiler here is trying to just figure out that inside of a do block,
  -- when you use the `bind`/`<-`, you should have something of form `f a`
  -- the compiler isn't very creative though, so of course it just iterates numbers on t...
  -- so in this, we have `t0 t1` instead of `f a`
  -- and so, that is why we get that some uninferred `t0 t1` doesn't match `String`.

  pure unit

module Main where

import System.Console.CmdArgs

import Application.HFastJetGen.Type
import Application.HFastJetGen.Command

main :: IO () 
main = do 
  putStrLn "HFastJet-generate"
  param <- cmdArgs mode

  commandLineProcess param
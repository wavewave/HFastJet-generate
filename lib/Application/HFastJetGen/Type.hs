{-# LANGUAGE DeriveDataTypeable #-}

module Application.HFastJetGen.Type where 

import System.Console.CmdArgs

data HFastJet_generate = Test 
              deriving (Show,Data,Typeable)

test :: HFastJet_generate
test = Test 

mode = modes [test]


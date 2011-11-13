{-# LANGUAGE DeriveDataTypeable #-}

module Application.HFastJetGen.Type where 

import System.Console.CmdArgs

data HFastJet_generate = Test { configfile :: FilePath } 
              deriving (Show,Data,Typeable)

test :: HFastJet_generate
test = Test { configfile = "HFastJet.conf" &= typ "CONFIGFILE" &= argPos 0 } 

mode = modes [test]


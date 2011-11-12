module Application.HFastJetGen.Command where

import Application.HFastJetGen.Type
import Application.HFastJetGen.Job

commandLineProcess :: HFastJet_generate -> IO ()
commandLineProcess Test = do 
  putStrLn "test called"
  startJob

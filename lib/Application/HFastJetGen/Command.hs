module Application.HFastJetGen.Command where


import Application.HFastJetGen.Type
import Application.HFastJetGen.Job

commandLineProcess :: HFastJet_generate -> IO ()
commandLineProcess (Test conf) = do 
  putStrLn "test called"
  startGenerateJob conf 

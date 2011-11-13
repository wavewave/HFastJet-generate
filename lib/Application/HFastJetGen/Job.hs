{-# LANGUAGE ScopedTypeVariables #-}


module Application.HFastJetGen.Job where

import System.IO
import System.FilePath 

import Text.Parsec
import Text.StringTemplate
import Text.StringTemplate.Helpers

import Bindings.Cxx.Generate.Config 
import Bindings.Cxx.Generate.Generator.Driver
import Bindings.Cxx.Generate.Generator.ContentMaker

import Application.HFastJetGen.Data.FastJet
import Application.HFastJetGen.Data.FastJetAnnotate

import System.Directory

import Paths_fficxx

startGenerateJob :: FilePath -> IO () 
startGenerateJob conf = do 
  putStrLn "Automatic HFastJet binding generation" 
  str <- readFile conf 
  let config = case (parse fficxxconfigParse "" str) of 
                 Left msg -> error (show msg)
                 Right ans -> ans

  putStrLn $ show config 

  let workingDir = fficxxconfig_workingDir config 
      ibase = fficxxconfig_installBaseDir config


  templateDir <- getDataDir >>= return . (</> "template")
  (templates :: STGroup String) <- directoryGroup templateDir 


  let prefix = "HEP.Jet.FastJet.Class"
  let cglobal = mkGlobal fastjet_all_classes
   
  putStrLn "header file generation"
  writeTypeDeclHeaders templates cglobal workingDir "HFastJet" fastjet_all_classes_imports
  mapM_ (writeDeclHeaders templates cglobal workingDir) fastjet_all_classes_imports

  putStrLn "cpp file generation" 
  mapM_ (writeCppDef templates workingDir) fastjet_all_classes_imports

  putStrLn "RawType.hs file generation" 
  mapM_ (writeRawTypeHs templates workingDir prefix) fastjet_all_modules 

  putStrLn "FFI.hsc file generation"
  mapM_ (writeFFIHsc templates workingDir prefix) fastjet_all_modules

  putStrLn "Interface.hs file generation" 
  mapM_ (writeInterfaceHs annotateMap templates workingDir prefix) fastjet_all_modules

  putStrLn "Cast.hs file generation"
  mapM_ (writeCastHs templates workingDir prefix) fastjet_all_modules

  putStrLn "Implementation.hs file generation"
  mapM_ (writeImplementationHs annotateMap templates workingDir prefix) fastjet_all_modules

  putStrLn "module file generation" 
  mapM_ (writeModuleHs templates workingDir prefix) fastjet_all_modules

  -- copyFile (workingDir </> cabalFileName)  ( ibase </> cabalFileName ) 
  -- copyPredefined templateDir (srcDir ibase)
  mapM_ (copyCppFiles workingDir (csrcDir ibase) "HFastJet") fastjet_all_classes_imports
  mapM_ (copyModule workingDir (srcDir ibase) prefix "HFastJet") fastjet_all_modules 

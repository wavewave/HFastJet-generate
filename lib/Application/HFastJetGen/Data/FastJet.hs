-- |
-- Module      : Application.HFastJetGen.Data.FastJet
-- Copyright   : (c) 2011 Ian-Woo Kim
-- 
-- License     : GPL-3
-- Maintainer  : ianwookim@gmail.com
-- Stability   : experimental
-- Portability : GHC
--
-- conversion data for FastJet classes 
--

module Application.HFastJetGen.Data.FastJet where

import Bindings.Cxx.Generate.Type.CType
import Bindings.Cxx.Generate.Type.Method
import Bindings.Cxx.Generate.Type.Class
import Bindings.Cxx.Generate.Type.Module


deletable :: Class 
deletable = AbstractClass "Deletable" [] 
          [ Destructor ]

deletableH = ClassImportHeader deletable "HFastJetDeletable.h" "HFastJetDeletable.cpp"
                               [] [] 
        
deletableM = ClassModule "Deletable" [deletable] [deletableH] [] [] []


fastjet_all_classes :: [Class]
fastjet_all_classes = 
  [ deletable ]

fastjet_all_classes_imports :: [ClassImportHeader]
fastjet_all_classes_imports = 
  [ deletableH ] 


fastjet_all_modules :: [ClassModule] 
fastjet_all_modules = [deletableM ] 

{-# LANGUAGE QuasiQuotes #-}

module Application.HFastJetGen.Data.FastJetAnnotate where

import Bindings.Cxx.Generate.Type.Annotate 
import Bindings.Cxx.Generate.QQ.Verbatim


import qualified Data.Map as M

annotateMap :: AnnotateMap 
annotateMap = M.empty 

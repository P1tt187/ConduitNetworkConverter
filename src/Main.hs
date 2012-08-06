{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Conduit
import Data.Conduit.Binary
import Data.Char
import Data.Conduit.Network as Nw
import Data.Conduit.List
import Control.Monad
import Data.Conduit.Text as Ct
import Data.Conduit.Binary as Cb

main::IO()
main = runTCPServer (ServerSettings 4000 HostAny) server
     
     
server::Nw.Application IO 
server src sink = do
        runResourceT ( src $$ (Cb.sinkFile "something.txt"))
        --Ct.decode Ct.utf8 =$ Ct.encode Ct.utf8 =$ 
        print "fertig"
            
       

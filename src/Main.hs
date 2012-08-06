{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Conduit
import Data.Conduit.Binary
import Data.Char
import Data.Conduit.Network
import Data.Conduit.List
import Control.Monad
import Data.Conduit.Text as Ct
import Data.Conduit.Binary as Cb

main::IO()
main = runTCPServer (ServerSettings 4000 HostAny) server
     
server::Application IO 
server src sink = do           
           src =$ Ct.decode Ct.utf8 =$ Ct.encode Ct.utf8 $$ Cb.sinkFile "something.txt"
           print "fertig"
            
       

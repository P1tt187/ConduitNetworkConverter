{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Conduit
import Data.Conduit.Network as Nw
import Data.Conduit.List
import Data.Conduit.Text as Ct
import Data.Conduit.Binary as Cb

main::IO()
main = runTCPServer (ServerSettings 4000 HostAny) server
     
     
server::Nw.Application IO 
server src sink = do
        x<- src $$ consume                    
        runResourceT $ sourceList x $$ Ct.decode Ct.utf8 =$ Ct.encode Ct.utf8 =$ Cb.sinkFile "something.txt"
        
        --print "fertig"
            
       

{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Conduit
import Data.Conduit.Network as Nw
import Data.Conduit.List
import Data.Conduit.Text as Ct
import Data.Conduit.Binary as Cb
import Text.Pandoc.Readers.Markdown as Prm
import Text.Pandoc.Writers.HTML as Pwh

main::IO()
main = runTCPServer (ServerSettings 4000 HostAny) server
     
     
server::GSource -> GSink
server src _ = do
        x<- src $$ consume                    
        runResourceT $ sourceList x $$ Ct.decode Ct.utf8 =$ Prm.readMarkdown =$ Pwh.writeHtmlString =$ Ct.encode Ct.utf8 =$ Cb.sinkFile "something.txt"
        
        --print "fertig"
            
       

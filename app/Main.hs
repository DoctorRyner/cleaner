module Main where

import System.Environment
import Control.Monad
import Cleaner

main :: IO ()
main = do
    args <- getArgs
    
    mapM_ clean args

    when (length args == 0) $
        putStrLn "Please, supply a list of paths"
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod.Core

import Usuario

mkYesodDispatch "App" resourcesApp

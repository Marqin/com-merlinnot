module Handler.Home where

import Import

getHomeR :: Handler Html
getHomeR =
  defaultLayout $ do
    setTitle "Consulting, mentoring, advising - merlinnot"
    $(widgetFile "homepage")

module Handler.Blog where

import Import

getBlogR :: Handler Html
getBlogR =
  defaultLayout $ do
    setTitle "merlinnot | blog"
    addStylesheetRemote "http://d2v52k3cl9vedd.cloudfront.net/basscss/7.0.4/basscss.min.css"
    $(widgetFile "blog")


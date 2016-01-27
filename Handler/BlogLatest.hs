module Handler.BlogLatest where

import Import
import qualified Database.Esqueleto as E
import qualified Network.HTTP.Types as H

getBlogLatestR :: Handler Html
getBlogLatestR = do
  allPosts <- runDB
    $ E.select
    $ E.from $ \p -> do
        E.orderBy [E.desc (p E.^. PostId)]
        return p
  let latestPostUrl :: Text
      latestPostUrl =
        case allPosts of
          [] -> ""
          Entity _ p:_ -> postUrl p
  case latestPostUrl of
    "" -> notFound
    _ ->
      redirectWith H.status303 (BlogR latestPostUrl)



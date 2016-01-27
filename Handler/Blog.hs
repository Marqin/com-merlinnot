module Handler.Blog where

import Import
import qualified Data.Text as T
import qualified Data.Text.Lazy as LazyT
import qualified Text.Blaze as Blaze
import qualified Database.Esqueleto as E
import qualified Text.Blaze.Html.Renderer.Text as Render
import qualified Text.Markdown as MD

getBlogR :: Text -> Handler Html
getBlogR url = do
  allPosts <- runDB
    $ E.select
    $ E.from $ \(p `E.LeftOuterJoin` b) -> do
        E.orderBy [E.desc (p E.^. PostId)]
        E.orderBy [E.desc (b E.^. PostBodyTime)]
        E.on $ p E.^. PostId E.==. b E.^. PostBodyPost
        return (p, b)
  let groupedPosts :: [[(Entity Post, Entity PostBody)]]
      groupedPosts =
        groupBy (\(Entity id1 _, _) (Entity id2 _, _) -> id1 == id2) allPosts
      posts :: [(Text, Text)]
      posts =
        map ((\(Entity _ p, Entity _ b) -> (postUrl p, postBodyTitle b)) . headEx) groupedPosts
      currentPost :: [(Entity Post, Entity PostBody)]
      currentPost = filter (\(Entity _ p, _) -> postUrl p == url) allPosts
      latestPost :: (Text, Text)
      latestPost =
        case allPosts of
          [] -> ("", "")
          (Entity _ p, Entity _ b):_ -> (postUrl p, postBodyTitle b)
  case currentPost of
    [] -> notFound
    (Entity _ cpostp, Entity _ cpostb):_ ->
      let body = Render.renderHtml $ MD.markdown MD.def $ LazyT.fromStrict $ postBodyBody cpostb in
      defaultLayout $ do
        setTitle $ Blaze.text (T.concat ["merlinnot | blog | ", postBodyTitle cpostb])
        $(widgetFile "blog")



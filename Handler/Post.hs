module Handler.Post where

import Import

postPostR :: Handler Value
postPostR = do
  req <- requireJsonBody :: Handler PostRequest
  _ <- runDB $ insertUnique $ Post (postRequestUrl req)
  post <- runDB $ getBy $ UniqueUrl (postRequestUrl req)
  _ <- case post of
    Nothing ->
      error "Could not save data - internal server error"
    Just (Entity postKey _) ->
      do
        time <- liftIO getCurrentTime
        runDB $ insert $
          PostBody postKey time (postRequestTitle req) (postRequestBody req)
  -- insert $ PostBody { post = post, title = req.title, body = req.body }
  -- insertedComment <- runDB $ insertEntity post
  returnJson req
  

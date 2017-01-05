defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # get "/", TopicController, :index
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "topics/:id", TopicController, :update
    # delete "/topics/:id", TopicController, :delete
    resources "/", TopicController
  end

  scope "/auth", Discuss do
    pipe_through :browser

    # Routes added using :provider to work (right now only with github):
    # "/auth/github"
    # "/auth/githu/callback"

    # Initially to authenticate with github
    get "/:provider", AuthController, :request
    # The route where the user is sent back from github itself
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end

defmodule Elixirer.Router do
  use Elixirer.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Elixirer.Auth, repo: Elixirer.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Elixirer do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index

    get "/", HomeController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/signin", SessionController, :new
    get "/signout", SessionController, :delete

    resources "/users", UserController
    get "/signup", UserController, :new

    resources "/posts", PostController
    get "/*category", PostController, :index
  end


  # Other scopes may use custom stacks.
  # scope "/api", Elixirer do
  #   pipe_through :api
  # end
end

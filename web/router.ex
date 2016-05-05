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
    get "/posts/*category", PostController, :index

    resources "/nodes", NodeController
  end

  scope "/admin", Elixirer do
    pipe_through [:browser, :authenticate_user]

    get "/", AdminController, :index

    resources "/posts", PostController
    resources "/nodes", NodeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Elixirer do
  #   pipe_through :api
  # end
end

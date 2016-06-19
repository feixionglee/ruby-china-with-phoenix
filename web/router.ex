defmodule Elixirer.Router do
  use Elixirer.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
    plug Elixirer.Auth, repo: Elixirer.Repo
    plug Elixirer.ActiveTab
    plug Elixirer.Locale
  end

  pipeline :csrf do
    plug :protect_from_forgery # to here
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Elixirer do
    pipe_through [:browser, :csrf] # Use the default browser stack

    get "/wiki", PageController, :index
    get "/wiki/:title", PageController, :show

    get "/", HomeController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/signin", SessionController, :new
    get "/signout", SessionController, :delete

    resources "/users", UserController, param: "name"

    get "/signup", UserController, :new

    resources "/posts", PostController do
      resources "/comments", CommentController
    end

    get "/categories/:category", PostController, :index, as: :category
    get "/search", SearchController, :index, as: :search

    resources "/nodes", NodeController, only: [:index, :show]
  end

  scope "/", Elixirer do
    pipe_through :browser

    post "/like_post/:id", PostController, :like
    post "/like_comment/:id", CommentController, :like
  end

  scope "/admin", alias: Elixirer.Admin, as: :admin  do
    pipe_through [:browser, :authenticate_user]

    get "/", BaseController, :index

    resources "/posts", PostController
    resources "/nodes", NodeController
  end

  # Other scopes may use custom stacks.
  scope "/api", Elixirer do
    pipe_through :api

    post "/photos", PhotoController, :create
  end
end

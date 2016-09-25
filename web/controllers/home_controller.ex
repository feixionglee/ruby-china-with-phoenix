defmodule Elixirer.HomeController do
  use Elixirer.Web, :controller

  alias Elixirer.Post

  def index(conn, _params) do
    query = from p in Post,
              preload: [:user, comments: [:user]]
    posts = Repo.all query

    render conn, "index.html", posts: posts
  end

end
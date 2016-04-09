defmodule Elixirer.HomeController do
  use Elixirer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
defmodule Elixirer.NodeController do
  use Elixirer.Web, :controller

  alias Elixirer.Node

  def show(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    render(conn, "show.html", node: node)
  end
end

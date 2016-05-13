defmodule Elixirer.NodeController do
  use Elixirer.Web, :controller

  alias Elixirer.Node

  def index(conn, _params) do
    nodes = Repo.all Node
    render(conn, "index.html", nodes: nodes)
  end

  def show(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    render(conn, "show.html", node: node)
  end
end

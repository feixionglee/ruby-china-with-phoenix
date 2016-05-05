defmodule Elixirer.NodeController do
  use Elixirer.Web, :controller

  alias Elixirer.Node

  def index(conn, _params) do
    nodes = Repo.all(Node)
    render(conn, "index.html", nodes: nodes)
  end

  def new(conn, _params) do
    changeset = Node.changeset(%Node{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"node" => node_params}) do
    changeset = Node.changeset(%Node{}, node_params)

    case Repo.insert(changeset) do
      {:ok, _node} ->
        conn
        |> put_flash(:info, "Node created successfully.")
        |> redirect(to: node_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    render(conn, "show.html", node: node)
  end

  def edit(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    changeset = Node.changeset(node)
    render(conn, "edit.html", node: node, changeset: changeset)
  end

  def update(conn, %{"id" => id, "node" => node_params}) do
    node = Repo.get!(Node, id)
    changeset = Node.changeset(node, node_params)

    case Repo.update(changeset) do
      {:ok, node} ->
        conn
        |> put_flash(:info, "Node updated successfully.")
        |> redirect(to: node_path(conn, :show, node))
      {:error, changeset} ->
        render(conn, "edit.html", node: node, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(node)

    conn
    |> put_flash(:info, "Node deleted successfully.")
    |> redirect(to: node_path(conn, :index))
  end
end

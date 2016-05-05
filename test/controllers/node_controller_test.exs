defmodule Elixirer.NodeControllerTest do
  use Elixirer.ConnCase

  alias Elixirer.Node
  @valid_attrs %{posts_count: 42, slug: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, node_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing nodes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, node_path(conn, :new)
    assert html_response(conn, 200) =~ "New node"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, node_path(conn, :create), node: @valid_attrs
    assert redirected_to(conn) == node_path(conn, :index)
    assert Repo.get_by(Node, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, node_path(conn, :create), node: @invalid_attrs
    assert html_response(conn, 200) =~ "New node"
  end

  test "shows chosen resource", %{conn: conn} do
    node = Repo.insert! %Node{}
    conn = get conn, node_path(conn, :show, node)
    assert html_response(conn, 200) =~ "Show node"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, node_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    node = Repo.insert! %Node{}
    conn = get conn, node_path(conn, :edit, node)
    assert html_response(conn, 200) =~ "Edit node"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    node = Repo.insert! %Node{}
    conn = put conn, node_path(conn, :update, node), node: @valid_attrs
    assert redirected_to(conn) == node_path(conn, :show, node)
    assert Repo.get_by(Node, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    node = Repo.insert! %Node{}
    conn = put conn, node_path(conn, :update, node), node: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit node"
  end

  test "deletes chosen resource", %{conn: conn} do
    node = Repo.insert! %Node{}
    conn = delete conn, node_path(conn, :delete, node)
    assert redirected_to(conn) == node_path(conn, :index)
    refute Repo.get(Node, node.id)
  end
end

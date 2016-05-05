defmodule Elixirer.NodeTest do
  use Elixirer.ModelCase

  alias Elixirer.Node

  @valid_attrs %{posts_count: 42, slug: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Node.changeset(%Node{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Node.changeset(%Node{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule Elixirer.CommentLikeTest do
  use Elixirer.ModelCase

  alias Elixirer.CommentLike

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CommentLike.changeset(%CommentLike{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CommentLike.changeset(%CommentLike{}, @invalid_attrs)
    refute changeset.valid?
  end
end

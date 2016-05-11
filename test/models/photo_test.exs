defmodule Elixirer.PhotoTest do
  use Elixirer.ModelCase

  alias Elixirer.Photo

  @valid_attrs %{name: "some content", target_id: 42, target_type: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Photo.changeset(%Photo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Photo.changeset(%Photo{}, @invalid_attrs)
    refute changeset.valid?
  end
end

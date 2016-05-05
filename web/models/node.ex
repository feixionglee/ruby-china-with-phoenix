defmodule Elixirer.Node do
  use Elixirer.Web, :model

  schema "nodes" do
    field :title, :string
    field :slug, :string
    field :posts_count, :integer

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :slug, :posts_count])
    |> validate_required([:title, :slug, :posts_count])
  end
end

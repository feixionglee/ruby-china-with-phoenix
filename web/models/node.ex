defmodule Elixirer.Node do
  use Elixirer.Web, :model

  schema "nodes" do
    field :title, :string
    field :slug, :string
    field :posts_count, :integer

    timestamps
  end


  @required_fields [:title, :slug]
  @optional_fields []

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required([:title, :slug])
  end
end

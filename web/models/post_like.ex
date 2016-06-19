defmodule Elixirer.PostLike do
  use Elixirer.Web, :model

  schema "post_likes" do
    belongs_to :user, Elixirer.User
    belongs_to :post, Elixirer.Post

    timestamps
  end

  # @required_fields ~w( post_id )
  @optional_fields ~w( post_id )

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [], @optional_fields)
    # |> validate_required([])
  end
end

defmodule Elixirer.CommentLike do
  use Elixirer.Web, :model

  schema "comment_likes" do
    belongs_to :user, Elixirer.User
    belongs_to :comment, Elixirer.Comment

    timestamps
  end

  # @required_fields ~w( comment_id )
  @optional_fields ~w( comment_id )

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [], @optional_fields)
    # |> validate_required([])
  end
end

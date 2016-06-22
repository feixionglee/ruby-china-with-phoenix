defmodule Elixirer.CommentLike do
  use Elixirer.Web, :model

  alias Elixirer.Repo
  alias Elixirer.CommentLike

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
  def changeset(struct, params \\ %{}, comment) do
    struct
    |> cast(params, [], @optional_fields)
    |> put_assoc(:comment, comment)
  end

  def liked?(comment, user) do
    case user do
      nil ->
        false
      _ ->
        query = from(p in CommentLike, where: p.comment_id == ^comment.id and p.user_id == ^user.id)
        Repo.one(query)
    end
  end
end

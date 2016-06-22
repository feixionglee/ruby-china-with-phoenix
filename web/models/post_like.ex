defmodule Elixirer.PostLike do
  use Elixirer.Web, :model

  alias Elixirer.Repo
  alias Elixirer.PostLike

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
  def changeset(model, params \\ %{}, post) do
    model
    |> cast(params, [], @optional_fields)
    |> put_assoc(:post, post)
  end

  def liked?(post, user) do
    case user do
      nil ->
        false
      _ ->
        query = from(p in PostLike, where: p.post_id == ^post.id and p.user_id == ^user.id)
        Repo.one(query)
    end
  end
end

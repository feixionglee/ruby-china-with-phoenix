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
  def changeset(model, params \\ %{}, post) do
    model
    |> cast(params, [], @optional_fields)
    |> put_assoc(:post, post)
  end

  # def likes_count(post) do
  #   query = from(p in PostLike, select: count("*"), where: p.post_id == ^post.id)
  #   Repo.one(query)
  # end
end

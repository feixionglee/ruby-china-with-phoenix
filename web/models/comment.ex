defmodule Elixirer.Comment do
  use Elixirer.Web, :model

  alias Elixirer.Post

  schema "comments" do
    field :content, :string
    field :state, :string
    belongs_to :user, Elixirer.User
    belongs_to :post, Elixirer.Post

    timestamps
  end

  @required_fields ~w( content )
  @optional_fields ~w( post_id )

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> put_change(:state, "normal")
    |> validate_length(:content, min: 3)
    |> assoc_constraint(:post)
  end

  def create_changeset(model, params \\ :empty, post) do
    changeset(model, params)
    |> Ecto.Changeset.put_assoc(:post, post)
    |> update_parent_counter(1)
  end

  def delete_changeset(model) do
    # we don't care about params, so we provide an empty Map
    changeset(model, %{})
    |> update_parent_counter(-1)
  end

  defp update_parent_counter(changeset, value) do
    changeset
    |> prepare_changes(fn prepared_changeset ->
      repo = prepared_changeset.repo
      # post_id = prepared_changeset.post_id
      post_id = prepared_changeset.changes.post.data.id

      from(p in Post, where: p.id == ^post_id)
      |> repo.update_all(inc: [comments_count: value])

      prepared_changeset
    end)
  end
end

defmodule Elixirer.Comment do
  use Elixirer.Web, :model

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
    |> assoc_constraint(:post)
  end
end

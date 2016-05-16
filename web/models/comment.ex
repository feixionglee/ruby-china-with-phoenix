defmodule Elixirer.Comment do
  use Elixirer.Web, :model

  schema "comments" do
    field :content, :string
    field :state, :string
    belongs_to :user, Elixirer.User
    belongs_to :post, Elixirer.Post

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :state])
    |> validate_required([:content, :state])
  end
end

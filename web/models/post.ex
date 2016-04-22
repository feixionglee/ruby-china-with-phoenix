defmodule Elixirer.Post do
  use Elixirer.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    field :category, :integer, default: 0
    belongs_to :user, Elixirer.User

    timestamps
  end

  @category %{
    "新手问题" => 1,
    "招聘" => 2
  }
  def category, do: @category


  @required_fields ~w(title content category)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 10, max: 60)
    |> validate_length(:content, min: 10)
  end
end

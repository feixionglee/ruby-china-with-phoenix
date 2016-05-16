defmodule Elixirer.Post do
  use Elixirer.Web, :model

  @primary_key {:id, Elixirer.Permalink, autogenerate: true}
  schema "posts" do
    field :title, :string
    field :slug, :string
    field :content, :string
    field :category, :string
    field :is_great, :boolean
    belongs_to :user, Elixirer.User

    timestamps
  end

  @category [
    "ask",
    "jobs",
    "meetup"
  ]
  def category, do: @category


  @required_fields ~w(title content category)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> strip_title()
    |> validate_length(:title, min: 10, max: 60)
    |> validate_length(:content, min: 10)
    |> slugify_title()
  end

  defp strip_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :title, String.strip(title))
    else
      changeset
    end
  end

  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

  defimpl Phoenix.Param, for: Elixirer.Post do
    def to_param(%{slug: slug, id: id}) do
      "#{id}-#{slug}"
    end
  end
end

defmodule Elixirer.Post do
  use Elixirer.Web, :model

  @primary_key {:id, Elixirer.Permalink, autogenerate: true}
  schema "posts" do
    field :title, :string
    field :slug, :string
    field :content, :string
    field :category, :string
    field :cityname, :string
    field :is_great, :boolean
    field :comments_count, :integer, default: 0
    belongs_to :user, Elixirer.User
    has_many :comments, Elixirer.Comment
    has_many :post_likes, Elixirer.PostLike
    embeds_one :location, Elixirer.Location, on_replace: :delete

    timestamps
  end

  @category [
    "ask",
    "jobs",
    "meetup",
    "newbie"
  ]
  def category, do: @category


  @required_fields ~w(title content category)
  @optional_fields ~w(cityname)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> strip_title()
    |> validate_length(:title, min: 3, max: 60)
    |> validate_length(:content, min: 3)
    |> slugify_title()
    |> embed_location(params)
  end

  def embed_location(changeset, params) do

    unless Map.has_key?(params, "location") do
      changeset
    else
      json = Poison.decode!(params["location"])
      location = %Elixirer.Location{
        module: json["module"],
        cityname: json["cityname"],
        lat: to_string(json["lat"]),
        lng: to_string(json["lng"]),
        poiaddress: json["poiaddress"],
        poiname: json["poiname"]
      }
      case location.module do
        "locationPicker"
          -> put_embed(changeset, :location, location)
        _
          -> changeset
      end
    end
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

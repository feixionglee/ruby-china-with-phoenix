defmodule Elixirer.Photo do
  use Elixirer.Web, :model

  schema "photos" do
    field :name, :string
    field :key, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :key])
    |> validate_required([:name, :key])
  end

  def remote_url arg do
    case arg do
      is_bitstring ->
        Qiniu.config[:cdn_host] <> "/" <> arg
      is_map ->
        Qiniu.config[:cdn_host] <> "/" <> arg[:key]
    end
  end

end

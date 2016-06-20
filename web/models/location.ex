require Poison
require Phoenix.HTML.Safe

defmodule Elixirer.Location do
  # use Elixirer.Web, :model
  use Ecto.Schema

  # embedded_schema is short for:
  #
  #   @primary_key {:id, :binary_id, autogenerate: true}
  #   schema "embedded Item" do
  #
  embedded_schema do
    field :module
    field :cityname
    # field :latlng
    field :lat
    field :lng
    field :poiaddress
    field :poiname
  end

  # @required_fields ~w(module cityname latlng poiaddress poiname)
  # @optional_fields ~w()

  # def changeset(model, params \\ %{}) do
  #   model
  #   |> cast(params, @required_fields, @optional_fields)
  # end

  defimpl Phoenix.HTML.Safe, for: Elixirer.Location do
    def to_iodata(dec) do
      Poison.encode!(dec)
    end
  end
end
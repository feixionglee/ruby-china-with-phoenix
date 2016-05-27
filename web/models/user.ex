require IEx
defmodule Elixirer.User do
  use Elixirer.Web, :model

  alias Elixirer.QiniuService

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :avatar, :string
    has_many :posts, Elixirer.Post
    has_many :comments, Elixirer.Comment

    timestamps
  end

  @required_fields ~w(name email password)
  @optional_fields ~w(avatar)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    params = QiniuService.photo_process(params, :avatar)
    model
    |> cast(params, ~w(name email), ~w(avatar))
    |> validate_length(:name, min: 4, max: 20)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:name)
    |> unique_constraint(:email)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end

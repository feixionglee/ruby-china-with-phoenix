require IEx
require AlchemicAvatar

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
    has_many :post_likes, Elixirer.PostLike
    has_many :comment_likes, Elixirer.CommentLike

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
    |> gen_avatar()
    |> put_pass_hash()
  end

  defp gen_avatar(changeset) do
    file = AlchemicAvatar.generate changeset.changes.name, 200

    put_change(changeset, :avatar, QiniuService.real_sync(file)["key"])
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  defimpl Phoenix.Param, for: Elixirer.User do
    def to_param(%{name: name}) do
      "#{name}"
    end
  end
end

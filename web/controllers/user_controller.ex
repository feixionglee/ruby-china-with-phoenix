defmodule Elixirer.UserController do
  use Elixirer.Web, :controller
  alias Elixirer.User

  # plug :authenticate when action in [:index, :show]
  plug :authenticate_user when action in [:edit, :update]

  def show(conn, %{"name" => name}) do
    user = Repo.get_by!(User, name: name)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Elixirer.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: home_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"name" => name}) do
    user = Repo.get_by!(User, name: name)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"name" => name, "user" => user_params}) do
    user = Repo.get_by!(User, name: name)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end
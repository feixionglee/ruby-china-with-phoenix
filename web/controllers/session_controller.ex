defmodule Elixirer.SessionController do
  use Elixirer.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"name" => user, "password" => pass}}) do
    case Elixirer.Auth.login_by_name_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: home_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid name/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Elixirer.Auth.logout()
    |> redirect(to: home_path(conn, :index))
  end
end
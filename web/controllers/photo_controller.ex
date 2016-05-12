defmodule Elixirer.PhotoController do
  use Elixirer.Web, :controller

  alias Elixirer.Photo

  def create(conn, %{"photo" => photo_params}, user) do
    changeset = Photo.changeset(%Photo{}, photo_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

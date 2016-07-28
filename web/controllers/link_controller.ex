require IEx
defmodule Elixirer.LinkController do
  use Elixirer.Web, :controller

  alias Elixirer.Post

  def index(conn, _params) do
    links = Repo.all(Post.link_query)
    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Post.link_changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    changeset = Post.link_changeset(%Post{}, Post.arrayed_tags(link_params))

    case Repo.insert(changeset) do
      {:ok, _link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: link_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Repo.get!(Post, id)
    render(conn, "show.html", link: link)
  end

  def edit(conn, %{"id" => id}) do
    link = Repo.get!(Post, id)
    changeset = Post.link_changeset(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Repo.get!(Post, id)
    changeset = Post.link_changeset(link, Post.arrayed_tags(link_params))

    case Repo.update(changeset) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: link_path(conn, :show, link))
      {:error, changeset} ->
        render(conn, "edit.html", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: link_path(conn, :index))
  end
end

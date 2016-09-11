require IEx
defmodule Elixirer.LinkController do
  use Elixirer.Web, :controller

  alias Elixirer.Post

  import Tirexs.HTTP

  plug :authenticate_user  when action in [:new, :create, :edit, :update, :like]

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:posts)
      |> Post.link_changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}, user) do
    changeset =
      user
      |> build_assoc(:posts)
      |> Post.link_changeset(Post.arrayed_tags(link_params))

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}, user) do
    link = Repo.get!(Post, id)
    changeset = Post.link_changeset(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}, user) do
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

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
        [conn, conn.params, conn.assigns.current_user])
  end

end

defmodule Elixirer.PostController do
  use Elixirer.Web, :controller

  alias Elixirer.Post

  plug :authenticate_user  when action in [:new, :create, :edit, :update]
  plug :load_categories when action in [:new, :create, :edit, :update]

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, %{"category" => category}, user) do
    posts = Repo.all from a in Post,
                        where: a.category == ^category,
                        preload: [:user]

    render(conn, "index.html", posts: posts)
  end

  def index(conn, _params, user) do
    posts = Repo.all from p in Post,
                        preload: [:user]

    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:posts)
      |> Post.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}, user) do
    changeset =
      user
      |> build_assoc(:posts)
      |> Post.changeset(post_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def show(conn, %{"id" => id}, user) do
    post = Repo.get!(Post, id) |> Repo.preload(:user)

    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}, user) do
    post = Repo.get!(user_posts(user), id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}, user) do
    post = Repo.get!(user_posts(user), id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
        [conn, conn.params, conn.assigns.current_user])
  end

  defp user_posts(user) do
      assoc(user, :posts)
  end

  defp load_categories(conn, _) do
    categories = Post.category
    assign(conn, :categories, categories)
  end
end

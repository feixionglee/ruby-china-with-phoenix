defmodule Elixirer.CommentController do
  use Elixirer.Web, :controller

  alias Elixirer.Post
  alias Elixirer.Comment

  plug :authenticate_user  when action in [:create, :edit, :update]

  def index(conn, _params, user) do
    comments = Repo.all(user_comments(user))
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:comments)
      |> Comment.changeset(%Comment{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}, user) do
    post = Repo.get Post, post_id
    changeset =
      user
        |> build_assoc(:comments)
        |> Comment.changeset(comment_params)
        |> Ecto.Changeset.put_assoc(:post, post)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        conn# render(conn, "new.html", changeset: changeset)
        |> redirect(to: post_path(conn, :show, post))
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}, user) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params, "post_id" => post_id}, user) do
    post = Repo.get Post, post_id
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, post) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: post_comment_path(conn, :index, post))
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
        [conn, conn.params, conn.assigns.current_user])
  end

  defp post_comments(post) do
    assoc(post, :comments)
  end

  defp user_comments(user) do
    assoc(user, :comments)
  end

  # defp fetch_post(conn, _) do
  #   post = Repo.get Post, conn.params["post_id"]
  #   conn
  #     |> assign(:post, post)
  # end

end
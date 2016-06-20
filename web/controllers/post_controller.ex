require Tirexs.HTTP

defmodule Elixirer.PostController do
  use Elixirer.Web, :controller

  alias Elixirer.Post
  alias Elixirer.Comment
  alias Elixirer.PostLike

  import Tirexs.HTTP

  plug :authenticate_user  when action in [:new, :create, :edit, :update, :like]
  plug :load_categories when action in [:new, :create, :edit, :update]

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, params, _user) do
    query = if params["category"] do
      from(p in Post, where: p.category == ^params["category"], preload: [:user, comments: [:user]])
    else
      from(p in Post, preload: [:user, comments: [:user]])
    end

    page = query
            |> Repo.paginate(params)

    render conn, "index.html",
      category: params["category"],
      posts: page.entries,
      page: page,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
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
        put("/elixirer/posts/#{post.id}", [title: post.title, content: post.content])
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def show(conn, %{"id" => id}, _user) do
    post =
      from(q in Post, preload: [:user, [comments: [:user, :comment_likes]], :post_likes])
      |> Repo.get!(id)


    changeset =
      post
      |> build_assoc(:comments)
      |> Comment.changeset()

    likes_count = length(post.post_likes)

    render(conn, "show.html", post: post, changeset: changeset, comments: post.comments, likes_count: likes_count)
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
        put("/elixirer/posts/#{post.id}", [title: post.title, content: post.content])
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    delete("/elixirer/posts/#{post.id}")

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  def like(conn, %{"id" => id}, user) do
    post = from(e in Post, preload: [:post_likes]) |> Repo.get(id)
    count = length post.post_likes

    post_like = Repo.get_by PostLike, post_id: post.id, user_id: user.id

    if post_like do
      case Repo.delete(post_like) do
        {:ok, _post_like} ->
          render conn, "like.json", post_id: post.id, likes_count: count - 1, liked: false
        {:error, _changeset} ->
          render conn, "like.json", post_id: post.id, likes_count: count, liked: true
      end
    else
      changeset = user
        |> build_assoc(:post_likes)
        |> PostLike.changeset(%{}, post)

      case Repo.insert(changeset) do
        {:ok, post_like} ->
          render conn, "like.json", post_id: post.id, likes_count: count + 1, liked: true
        {:error, changeset} ->
          render conn, "like.json", post_id: post.id, likes_count: count, liked: false
      end
    end
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

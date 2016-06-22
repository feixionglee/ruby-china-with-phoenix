defmodule Elixirer.CommentView do
  use Elixirer.Web, :view

  def render("like.json", %{comment_id: comment_id, likes_count: likes_count, liked: liked}) do
    %{comment_id: comment_id, likes_count: likes_count, liked: liked}
  end
end

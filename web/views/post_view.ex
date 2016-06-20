defmodule Elixirer.PostView do
  use Elixirer.Web, :view

  import Scrivener.HTML

  def render("like.json", %{post_id: post_id, likes_count: likes_count, liked: liked}) do
    %{post_id: post_id, likes_count: likes_count, liked: liked}
  end
end

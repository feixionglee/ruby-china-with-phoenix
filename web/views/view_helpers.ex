defmodule Elixirer.ViewHelpers do
  use Phoenix.HTML
  alias Elixirer.User

  def avatar_url(user) do
    case user.avatar do
      nil ->
        AlchemicAvatar.generate user.name, 200
      _ ->
        Elixirer.Photo.remote_url(user.avatar)
    end
  end

  def last_comment_at(comments) do
    comment = List.last(comments)
    "Last by <a data-name=\"#{comment.user.name}\" href=\"/users/#{comment.user.name}\">#{comment.user.name}</a> Replied at #{comment.inserted_at}"
  end
end
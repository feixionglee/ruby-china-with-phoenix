defmodule Elixirer.ViewHelpers do
  use Phoenix.HTML
  alias Elixirer.User

  def avatar_url(user) do
    Elixirer.Photo.remote_url(user.avatar)
  end
end
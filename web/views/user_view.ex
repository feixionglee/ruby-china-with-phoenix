defmodule Elixirer.UserView do
  use Elixirer.Web, :view

  alias Elixirer.User

  def avatar_url(user) do
    Elixirer.Photo.remote_url(user.avatar)
  end
end
defmodule Elixirer.Repo do
  use Ecto.Repo, otp_app: :elixirer
  use Scrivener, page_size: 10
end

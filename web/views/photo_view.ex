defmodule Elixirer.PhotoView do
  use Elixirer.Web, :view

  def render("create.json", %{url: url}) do
    %{
      files: [
        %{
          url: url
        }
      ]
    }
  end
end

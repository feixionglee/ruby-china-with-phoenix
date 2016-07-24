defmodule Elixirer.PhotoView do
  use Elixirer.Web, :view

  def render("create.json", %{name: name, url: url}) do
    %{
      files: [
        %{
          name: name,
          url: url
        }
      ]
    }
  end
end

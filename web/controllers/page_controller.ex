require IEx

defmodule Elixirer.PageController do
  use Elixirer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"title" => title}) do
    try do
      output = Path.join("web/templates/page", [title, ".md"])
        |> File.read!
        |> Earmark.to_html
      # put_layout(conn, "post.html")
      render conn, "show.html", output: output
    rescue
      _ ->
        conn
          |> put_status(:not_found)
          |> render(Elixirer.ErrorView, "404.html")
    end
  end
end

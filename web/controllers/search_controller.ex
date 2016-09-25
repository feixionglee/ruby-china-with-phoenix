require IEx
require Tirexs.Search

defmodule Elixirer.SearchController do
  use Elixirer.Web, :controller

  use ScrivenerElasticsearch, page_size: 10

  import Tirexs.Search

  alias Elixirer.Post

  plug :sanitize_q

  def index(conn, params) do
    qstr = params["q"]
    page_number = case params["page"] do
      nil -> 1
      ~r/\D/ -> 1
      _ -> String.to_integer(params["page"])
    end

    size = 2
    from = size * ( page_number - 1 )

    query = search [index: "elixirer", type: "posts", size: size, from: from] do
      query do
        bool do
          should do
            match "title", qstr
            match "content", qstr
          end
        end
      end
    end

    case Tirexs.Query.create_resource(query) do
      {:ok, 200, result} ->
        page = paginate result, params
        # IEx.pry
        render conn, "index.html",
          q: params["q"],
          posts: page.entries,
          page: page,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries
      # {:error, 404, result} ->
      _ ->
        render(conn, Elixirer.ErrorView, "404.html")
    end
  end

  defp sanitize_q(conn, _opts) do
    if is_nil(conn.params["q"]) || conn.params["q"] == "" do
      conn
      |> redirect(to: home_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end
require IEx
require Tirexs.Search

defmodule Elixirer.SearchController do
  use Elixirer.Web, :controller

  import Tirexs.Search

  alias Elixirer.Post

  def index(conn, params) do
    qstr = params["q"]
    page_number = case params["page"] do
      nil -> 1
      ~r/\D/ -> 1
      _ -> String.to_integer(params["page"])
    end

    if is_nil(qstr) || String.length(qstr) == 0 do
      conn |> redirect to: home_path(conn, :index)
      # redirect conn, to: "/"
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
        # IEx.pry
        page = ScrivenerElasticsearch.paginate result, params

        render conn, "index.html",
          posts: page.entries,
          page: page,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries
      {:error, 404, result} ->
        render(conn, Elixirer.ErrorView, "404.html")
    end
  end

end
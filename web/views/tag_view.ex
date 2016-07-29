defmodule Elixirer.TagView do
  use Elixirer.Web, :view

  # import Scrivener.HTML

  def render("autocomplete.json", %{}) do
    %{_query: "query_str", value: "test"}
  end

  def render("autocomplete.json", %{query: query_str}) do
    %{_query: query_str, value: 'test'}
  end
end

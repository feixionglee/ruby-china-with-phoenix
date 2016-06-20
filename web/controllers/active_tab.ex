defmodule Elixirer.ActiveTab do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    active_tab =
      case conn.params do
        %{"category" => cate_name} when cate_name in ["jobs", "ask", "meetup"] ->
          String.to_atom cate_name
        %{"category" => _} ->
          :posts
        %{} ->
          if conn.path_info == [] do
            :empty
          else
            String.to_atom List.first(conn.path_info)
          end
        _ ->
          :empty
      end
    assign(conn, :active_tab, active_tab)
  end
end
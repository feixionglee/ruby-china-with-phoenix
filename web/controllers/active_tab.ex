defmodule Elixirer.ActiveTab do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    active_tab =
      case conn.path_info do
        [] ->
          ""
        [active] ->
          String.to_atom active
        ["categories", cate_name] when cate_name in ["jobs", "ask", "meetup"] ->
          String.to_atom cate_name
        ["categories", _] ->
          :posts
        _ ->
          String.to_atom List.first(conn.path_info)
      end
    assign(conn, :active_tab, active_tab)
  end
end
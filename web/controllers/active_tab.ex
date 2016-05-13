defmodule Elixirer.ActiveTab do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    # IEx.pry
    active_tab =
      case List.first(conn.path_info) do
        "category"->
          :posts
        _ ->
          String.to_atom List.first(conn.path_info)
      end
    assign(conn, :active_tab, active_tab)
  end
end
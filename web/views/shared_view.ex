defmodule Elixirer.SharedView do
  use Elixirer.Web, :view

  def state_link conn, opts, do: content do
    state_link conn, content, opts
  end

  def state_link conn, content, opts do
    {active, opts} = Keyword.pop(opts, :active)

    content_tag :li, class: (if conn.assigns.active_tab == active, do: "active", else: "") do
      link content, opts
    end
  end
end
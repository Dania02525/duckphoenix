defmodule PlugMock do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    set_resource(conn)
  end

  defp set_resource(conn) do
    conn = set_assigns(conn, conn.path_info |> List.delete("api"))
    conn
  end

  defp set_assigns(conn, [ k | [] ]) do
    conn |> assign(:type, k) |> assign(:id, nil)
  end

  defp set_assigns(conn, [ k, v | [] ]) do
    conn |> assign(:type, k) |> assign(:id, v)
  end

  defp set_assigns(conn, [ h, h2 | t ]) do
    set_assigns(conn, t)
  end
end
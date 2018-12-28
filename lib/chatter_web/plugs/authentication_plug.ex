defmodule ChatterWeb.AuthenticationPlug do
  @behaviour Plug

  import Plug.Conn, only: [halt: 1]
  import Phoenix.Controller, only: [redirect: 2]

  alias ChatterWeb.Router.Helpers, as: Routes

  def init(default), do: default

  def call(conn, _default) do
    if Chatter.Session.signed_in?(conn) do
      conn
    else
      conn
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end

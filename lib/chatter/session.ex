defmodule Chatter.Session do
  import Plug.Conn

  alias Chatter.User

  def signed_in?(conn) do
    user = current_user(conn)
    !User.guest?(user)
  end

  def sign_in(conn, as: username) do
    conn
    |> put_session(:current_user, User.new(username))
  end

  def current_user(conn) do
    case get_session(conn, :current_user) do
      nil -> User.guest_user()
      user -> user
    end
  end
end

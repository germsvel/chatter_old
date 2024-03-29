defmodule ChatterWeb.SessionController do
  use ChatterWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"username" => username}) do
    rooms = Chatter.Chat.all_rooms()

    conn
    |> Chatter.Session.sign_in(as: username)
    |> assign(:rooms, rooms)
    |> redirect(to: Routes.chat_room_path(conn, :index))
  end
end

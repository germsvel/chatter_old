defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    rooms = Chatter.Chat.all_rooms()

    render(conn, "index.html", rooms: rooms)
  end
end

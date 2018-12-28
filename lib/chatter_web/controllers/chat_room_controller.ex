defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    rooms = Chatter.Chat.all_rooms()

    render(conn, "index.html", rooms: rooms)
  end

  def show(conn, %{"id" => id}) do
    room = Chatter.Chat.get_room!(id)

    render(conn, "show.html", room: room)
  end

  def new(conn, _params) do
    changeset = Chatter.Chat.new_changes()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => params}) do
    case Chatter.Chat.create_room(params) do
      {:ok, _room} ->
        conn
        |> assign(:rooms, Chatter.Chat.all_rooms())
        |> redirect(to: Routes.chat_room_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

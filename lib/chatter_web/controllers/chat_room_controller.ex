defmodule ChatterWeb.ChatRoomController do
  use ChatterWeb, :controller

  plug :authenticate

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

  defp authenticate(conn, _) do
    if Chatter.Session.signed_in?(conn) do
      conn
    else
      conn
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end

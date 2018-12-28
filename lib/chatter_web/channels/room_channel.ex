defmodule ChatterWeb.RoomChannel do
  use ChatterWeb, :channel

  def join("room:" <> _room_name, _msg, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    outgoing_payload = add_author(payload, socket)

    broadcast(socket, "new_message", outgoing_payload)
    {:noreply, socket}
  end

  defp add_author(payload, socket) do
    Map.put(payload, "author", socket.assigns.username)
  end
end

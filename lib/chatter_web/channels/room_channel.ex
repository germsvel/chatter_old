defmodule ChatterWeb.RoomChannel do
  use ChatterWeb, :channel

  def join("room:" <> _room_name, _msg, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast(socket, "new_message", payload)
    {:noreply, socket}
  end
end

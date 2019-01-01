defmodule ChatterWeb.RoomChannel do
  use ChatterWeb, :channel

  def join("room:" <> room_name, _msg, socket) do
    history =
      room_name
      |> Chatter.History.history_for_room()
      |> Enum.map(&Tuple.to_list/1)

    {:ok, %{history: history}, assign(socket, :room, room_name)}
  end

  def handle_in("new_message", payload, socket) do
    outgoing_payload = add_author(payload, socket)

    add_entry_to_history(socket.assigns.room, outgoing_payload)

    broadcast(socket, "new_message", outgoing_payload)
    {:noreply, socket}
  end

  defp add_entry_to_history(room_name, payload) do
    %{"author" => author, "body" => message} = payload
    Chatter.History.add_entry(room_name, {author, message})
  end

  defp add_author(payload, socket) do
    Map.put(payload, "author", socket.assigns.username)
  end
end

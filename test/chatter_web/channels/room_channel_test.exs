defmodule ChatterWeb.RoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  alias ChatterWeb.RoomChannel

  describe "join" do
    test "replies with chat history" do
      room = insert(:room) |> with_history()
      Chatter.History.add_entry(room.name, {"author", "message"})

      {:ok, reply, _socket} = join_room_channel(room.name, as: "random")

      assert reply.history == [["author", "message"]]
    end
  end

  describe "handle_in(new_message)" do
    test "broadcasts message to all users (tagged by author)" do
      room = insert(:room) |> with_history()
      username = "german"
      {:ok, _, socket} = join_room_channel(room.name, as: username)

      incoming_payload = %{"body" => "hello world"}
      push(socket, "new_message", incoming_payload)

      outgoing_payload = Map.put(incoming_payload, "author", username)
      assert_broadcast "new_message", ^outgoing_payload
    end

    test "stores each message in history" do
      room = insert(:room) |> with_history()
      {:ok, _, socket} = join_room_channel(room.name, as: "german")

      push(socket, "new_message", %{"body" => "hello world"})

      assert_broadcast "new_message", _
      assert {"german", "hello world"} in Chatter.History.history_for_room(room.name)
    end
  end

  defp join_room_channel(room_name, as: username) do
    ChatterWeb.UserSocket
    |> socket("", %{username: username})
    |> subscribe_and_join(RoomChannel, "room:#{room_name}")
  end
end

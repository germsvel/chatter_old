defmodule ChatterWeb.RoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  alias ChatterWeb.RoomChannel

  describe "handle_in new_message" do
    test "broadcasts message to all users (tagged by author)" do
      username = "german"
      {:ok, _, socket} = join_room_channel(as: username)

      incoming_payload = %{"body" => "hello world"}
      push(socket, "new_message", incoming_payload)

      outgoing_payload = Map.put(incoming_payload, "author", username)
      assert_broadcast "new_message", ^outgoing_payload
    end
  end

  defp join_room_channel(as: username) do
    ChatterWeb.UserSocket
    |> socket("", %{username: username})
    |> subscribe_and_join(RoomChannel, "room:general")
  end
end

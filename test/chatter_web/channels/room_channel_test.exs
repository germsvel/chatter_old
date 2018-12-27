defmodule ChatterWeb.RoomChannelTest do
  use ChatterWeb.ChannelCase, async: true

  alias ChatterWeb.RoomChannel

  describe "handle_in new_message" do
    test "broadcasts message to all users" do
      {:ok, _, socket} = join_room_channel()
      payload = %{"body" => "hello world"}

      push(socket, "new_message", payload)

      assert_broadcast "new_message", ^payload
    end
  end

  defp join_room_channel do
    ChatterWeb.UserSocket
    |> socket("", %{})
    |> subscribe_and_join(RoomChannel, "room:general")
  end
end

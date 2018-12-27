defmodule Chatter.ChatTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat

  describe "get_room!" do
    test "gets a room" do
      room = insert(:room)

      assert room == Chat.get_room!(room.id)
    end
  end

  describe "create_room" do
    test "creates a new room" do
      room_params = string_params_for(:room)

      {:ok, room} = Chat.create_room(room_params)

      assert room.name == room_params["name"]
    end
  end
end

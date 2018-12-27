defmodule Chatter.ChatTest do
  use Chatter.DataCase, async: true

  alias Chatter.Chat

  describe "create_room" do
    test "creates a new room" do
      room_params = string_params_for(:room)

      {:ok, room} = Chat.create_room(room_params)

      assert room.name == room_params["name"]
    end
  end
end

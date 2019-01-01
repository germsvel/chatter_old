defmodule Chatter.HistoryTest do
  use Chatter.DataCase, async: true

  alias Chatter.History

  describe "start_all" do
    test "starts a history process for each chat room" do
      rooms = insert_pair(:room)

      History.start_all()

      for room <- rooms do
        assert History.exists?(room.name)
      end
    end
  end

  describe "for_room" do
    test "returns history given a room name" do
      room = insert(:room)
      {:ok, _room} = History.start_room(room.name)
      History.add_entry(room.name, {"author", "message"})

      history = History.history_for_room(room.name)

      assert {"author", "message"} in history
    end
  end

  describe "exists?" do
    test "returns true if history process exists for room" do
      room = build(:room)

      {:ok, _room} = History.start_room(room.name)

      assert History.exists?(room.name)
    end
  end
end

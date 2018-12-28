defmodule ChatterWeb.UsersCanChatTest do
  use ChatterWeb.FeatureCase, async: true

  test "two users can chat in a room succesfully", %{sandbox_metadata: metadata} do
    room = insert(:room)

    user1 =
      metadata
      |> new_user()
      |> visit(home_page())
      |> sign_in()
      |> join_room(room.name)

    user2 =
      metadata
      |> new_user()
      |> visit(home_page())
      |> sign_in()
      |> join_room(room.name)

    user1
    |> add_message("Hello Josh")

    user2
    |> assert_has(message("Hello Josh"))
    |> add_message("Hi German")

    user1
    |> assert_has(message("Hi German"))
  end

  defp new_user(metadata) do
    {:ok, user} = Wallaby.start_session(metadata: metadata)
    user
  end
end

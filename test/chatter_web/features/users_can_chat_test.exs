defmodule ChatterWeb.UsersCanChatTest do
  use ChatterWeb.FeatureCase, async: true

  test "two users can chat in a room succesfully", %{sandbox_metadata: metadata} do
    room = insert(:room) |> with_history()

    user1 =
      metadata
      |> new_user()
      |> visit(home_page())
      |> sign_in(as: "german")
      |> join_room(room.name)

    user2 =
      metadata
      |> new_user()
      |> visit(home_page())
      |> sign_in(as: "josh")
      |> join_room(room.name)

    user1
    |> add_message("Hello Josh")

    user2
    |> assert_has(message("german: Hello Josh"))
    |> add_message("Hi German")

    user1
    |> assert_has(message("josh: Hi German"))
  end

  test "user can see history when joining room", %{sandbox_metadata: metadata} do
    room = insert(:room) |> with_history()

    metadata
    |> new_user()
    |> visit(home_page())
    |> sign_in(as: "german")
    |> join_room(room.name)
    |> add_message("Hello everyone")
    |> add_message("I am new to the area")

    metadata
    |> new_user()
    |> visit(home_page())
    |> sign_in()
    |> join_room(room.name)
    |> assert_has(message("german: Hello everyone"))
    |> assert_has(message("german: I am new to the area"))
  end

  defp new_user(metadata) do
    {:ok, user} = Wallaby.start_session(metadata: metadata)
    user
  end
end

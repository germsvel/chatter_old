defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can see all available rooms", %{session: session} do
    insert_pair(:room)

    session
    |> visit(home_page())
    |> assert_has(number_of_rooms(2))
  end

  test "user can create a new room", %{session: session} do
    name = "elixir"

    session
    |> visit(home_page())
    |> add_room(name: name)
    |> assert_has(room_name(name))
  end
end

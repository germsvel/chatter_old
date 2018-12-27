defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2, button: 1, link: 1, text_field: 1]
  import Chatter.Factory

  test "user can see all available rooms", %{session: session} do
    insert_pair(:room)

    session
    |> visit("/")
    |> assert_has(css(".rooms li", count: 2))
  end

  test "user can create a new room", %{session: session} do
    name = "elixir"

    session
    |> visit("/")
    |> click(link("Add room"))
    |> fill_in(text_field("Room name"), with: name)
    |> click(button("Create"))
    |> assert_has(css(".room", text: name))
  end
end

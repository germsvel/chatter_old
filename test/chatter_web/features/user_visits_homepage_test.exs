defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]
  import Chatter.Factory

  test "can see all available rooms", %{session: session} do
    insert_pair(:room)

    session
    |> visit("/")
    |> assert_has(css(".rooms li", count: 2))
  end
end

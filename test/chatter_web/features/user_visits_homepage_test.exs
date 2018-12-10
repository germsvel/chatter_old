defmodule ChatterWeb.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "successfully", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".title", text: "Welcome to Chatter"))
  end
end

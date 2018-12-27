defmodule ChatterWeb.ChatRoomControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create" do
    test "redirects to index page on success", %{conn: conn} do
      params = string_params_for(:room)

      resp = post conn, Routes.chat_room_path(conn, :create), %{"room" => params}

      assert html_response(resp, 302) =~ "redirect"
    end

    test "renders new page on failure", %{conn: conn} do
      insert(:room, name: "elixir")
      params = string_params_for(:room, name: "elixir")

      resp = post conn, Routes.chat_room_path(conn, :create), %{"room" => params}

      assert html_response(resp, 200) =~ "has already been taken"
    end
  end
end

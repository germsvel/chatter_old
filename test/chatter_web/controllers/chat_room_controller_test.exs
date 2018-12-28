defmodule ChatterWeb.ChatRoomControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "index" do
    test "redirects to sign in page if not signed in", %{conn: conn} do
      resp =
        conn
        |> get(Routes.chat_room_path(conn, :index))
        |> html_response(302)

      assert resp =~ "redirected"
      assert resp =~ Routes.session_path(conn, :new)
    end

    test "renders index page if signed in", %{conn: conn} do
      room = insert(:room)

      resp =
        conn
        |> sign_in()
        |> get(Routes.chat_room_path(conn, :index))
        |> html_response(200)

      assert resp =~ room.name
    end
  end

  describe "create" do
    test "redirects to index page on success", %{conn: conn} do
      params = string_params_for(:room)

      resp =
        conn
        |> sign_in()
        |> post(Routes.chat_room_path(conn, :create), %{"room" => params})
        |> html_response(302)

      assert resp =~ "redirected"
      assert resp =~ Routes.chat_room_path(conn, :index)
    end

    test "renders new page on failure", %{conn: conn} do
      insert(:room, name: "elixir")
      params = string_params_for(:room, name: "elixir")

      resp =
        conn
        |> sign_in()
        |> post(Routes.chat_room_path(conn, :create), %{"room" => params})
        |> html_response(200)

      assert resp =~ "has already been taken"
    end
  end

  defp sign_in(conn) do
    conn
    |> Plug.Test.init_test_session(foo: "bar")
    |> Chatter.Session.sign_in(as: "random user")
  end
end

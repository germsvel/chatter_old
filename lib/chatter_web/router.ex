defmodule ChatterWeb.Router do
  use ChatterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatterWeb do
    pipe_through :browser

    get "/", ChatRoomController, :index
    resources "/chat_rooms", ChatRoomController, only: [:new, :create, :show]
    resources "/sessions", SessionController, only: [:new, :create]
  end

  defp set_current_user(conn, _) do
    user = Chatter.Session.current_user(conn)
    assign(conn, :current_user, user)
  end
end

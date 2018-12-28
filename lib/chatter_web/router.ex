defmodule ChatterWeb.Router do
  use ChatterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_username
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

  defp set_username(conn, _) do
    username = get_session(conn, :username)
    assign(conn, :username, username)
  end
end

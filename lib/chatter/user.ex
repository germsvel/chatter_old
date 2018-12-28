defmodule Chatter.User do
  defstruct [:username]

  alias Chatter.User

  @guest_username "guest"

  def new(username) do
    %User{username: username}
  end

  def guest_user do
    %User{username: @guest_username}
  end

  def guest?(%User{username: @guest_username}), do: true
  def guest?(%User{username: _}), do: false
end

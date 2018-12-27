defmodule Chatter.Chat do
  alias Chatter.{Chat, Repo}

  def all_rooms do
    Repo.all(Chat.Room)
  end

  def new_changes do
    %Chat.Room{}
    |> Chat.Room.changeset(%{})
  end

  def create_room(params) do
    %Chat.Room{}
    |> Chat.Room.changeset(params)
    |> Repo.insert()
  end
end

defmodule Chatter.Chat do
  alias Chatter.Chat.Room
  alias Chatter.Repo

  def all_rooms do
    Repo.all(Room)
  end

  def new_changes(params \\ %{}) do
    %Room{}
    |> Room.changeset(params)
  end

  def get_room!(id), do: Repo.get!(Room, id)

  def create_room(params) do
    params
    |> new_changes()
    |> Repo.insert()
  end
end

defmodule Chatter.History do
  use DynamicSupervisor

  alias Chatter.Chat
  alias Chatter.History.Room

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_all do
    for room <- Chat.all_rooms() do
      start_room(room.name)
    end
  end

  def start_room(name) do
    spec = {Room, name: String.to_atom(name)}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def add_entry(name, entry) do
    name
    |> String.to_atom()
    |> Room.add_entry(entry)
  end

  def history_for_room(name) do
    name
    |> String.to_atom()
    |> Room.all_entries()
  end

  def exists?(name) do
    pid_or_nil =
      name
      |> String.to_atom()
      |> Process.whereis()

    !is_nil(pid_or_nil)
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end

defmodule Chatter.Factory do
  use ExMachina.Ecto, repo: Chatter.Repo

  alias Chatter.Chat

  def room_factory do
    %Chat.Room{
      name: sequence(:room, &"room#{&1}")
    }
  end
end

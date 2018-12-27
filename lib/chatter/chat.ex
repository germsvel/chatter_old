defmodule Chatter.Chat do
  alias Chatter.{Chat, Repo}

  def all_rooms do
    Repo.all(Chat.Room)
  end
end

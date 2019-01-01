defmodule Chatter.History.Room do
  use Agent

  def start_link(opts) do
    name = Keyword.fetch!(opts, :name)

    Agent.start_link(fn -> [] end, name: name)
  end

  def add_entry(pid, entry) do
    Agent.update(pid, fn entries ->
      [entry | entries]
    end)
  end

  def all_entries(pid) do
    Agent.get(pid, fn entries -> entries end)
  end
end

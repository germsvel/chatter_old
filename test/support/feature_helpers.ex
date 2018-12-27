defmodule ChatterWeb.Feature.Helpers do
  use Wallaby.DSL

  import Wallaby.Query, only: [css: 2, button: 1, link: 1, text_field: 1]

  def home_page do
    "/"
  end

  def number_of_rooms(number) do
    css(".rooms li", count: number)
  end

  def room_name(name) do
    css(".room", text: name)
  end

  def message(message) do
    css(".messages > li", text: message)
  end

  def add_room(session, name: name) do
    session
    |> click(link("Add room"))
    |> fill_in(text_field("Room name"), with: name)
    |> click(button("Create"))
  end

  def join_room(session, name) do
    session
    |> click(link(name))
  end

  def add_message(session, message) do
    session
    |> fill_in(text_field("New Message"), with: message)
    |> click(button("Send"))
  end
end

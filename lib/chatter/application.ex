defmodule Chatter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Chatter.Repo,
      ChatterWeb.Endpoint,
      Chatter.History,
      {Task, &Chatter.History.start_all/0}
    ]

    opts = [strategy: :one_for_one, name: Chatter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChatterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

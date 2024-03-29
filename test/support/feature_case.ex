defmodule ChatterWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Chatter.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Chatter.Factory

      import ChatterWeb.Router.Helpers
      import ChatterWeb.Feature.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Chatter.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Chatter.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Chatter.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session, sandbox_metadata: metadata}
  end
end

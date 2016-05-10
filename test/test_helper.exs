ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Duckphoenix.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Duckphoenix.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Duckphoenix.Repo)


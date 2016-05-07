ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Habanero.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Habanero.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Habanero.Repo)


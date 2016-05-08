defmodule Habanero.Repo.Migrations.AddComplexityToSubject do
  use Ecto.Migration

  def change do
    alter table(:subjects) do
      add :complexity, :string
    end
  end
end

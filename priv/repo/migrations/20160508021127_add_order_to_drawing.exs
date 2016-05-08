defmodule Habanero.Repo.Migrations.AddOrderToDrawing do
  use Ecto.Migration

  def change do
    alter table(:drawings) do
      add :order, :integer
    end
  end
end

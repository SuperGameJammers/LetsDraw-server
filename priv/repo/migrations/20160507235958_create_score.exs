defmodule Habanero.Repo.Migrations.CreateScore do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :rate, :integer
      add :img_url, :string
 
      add :drawing_id, references(:drawings)

      timestamps
    end

  end
end

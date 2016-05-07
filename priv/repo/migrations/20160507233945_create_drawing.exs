defmodule Habanero.Repo.Migrations.CreateDrawing do
  use Ecto.Migration

  def change do
    create table(:drawings) do
      add :img_url, :string
      add :name, :string
      
      add :subject_id, references(:subjects)

      timestamps
    end

  end
end

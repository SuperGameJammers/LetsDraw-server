defmodule Habanero.Repo.Migrations.CreateSubject do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
      add :img_url, :string

      timestamps
    end

  end
end

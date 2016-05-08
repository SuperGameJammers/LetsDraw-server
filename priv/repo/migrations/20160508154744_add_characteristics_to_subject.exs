defmodule Habanero.Repo.Migrations.AddCharacteristicsToSubject do
  use Ecto.Migration

  def change do
    alter table(:subjects) do
          add :characteristics, {:array, :string}
        end
	alter table(:drawings) do
		 add :characteristics, {:array, :string}
	   end
  end
end

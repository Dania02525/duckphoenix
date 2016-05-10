defmodule Duckphoenix.Repo.Migrations.CreateResource do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :type, :string
      add :data, :map

      timestamps
    end

  end
end

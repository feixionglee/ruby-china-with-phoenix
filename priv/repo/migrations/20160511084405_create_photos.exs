defmodule Elixirer.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
     create table(:photos) do
      add :name, :string
      add :key, :string

      timestamps
    end

    create unique_index(:photos, [:key])
  end
end

defmodule Elixirer.Repo.Migrations.AddLocationToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :cityname, :string
      add :location, :map
    end
  end
end

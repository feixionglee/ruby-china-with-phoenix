defmodule Elixirer.Repo.Migrations.AddIsGreatToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :is_great, :boolean, default: false
    end
  end
end

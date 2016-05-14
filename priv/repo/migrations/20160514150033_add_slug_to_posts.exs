defmodule Elixirer.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :slug, :string, default: "", null: false
    end
  end
end

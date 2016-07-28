defmodule Elixirer.Repo.Migrations.AddTagsToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :url, :string
      add :tags, {:array, :string}
    end
  end
end

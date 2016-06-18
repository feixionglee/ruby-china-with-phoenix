defmodule Elixirer.Repo.Migrations.AddCommentsCountToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :comments_count, :integer, null: false, default: 0
    end
  end
end

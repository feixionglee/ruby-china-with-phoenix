defmodule Elixirer.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :category, :integer, default: 0, null: false

      timestamps
    end
    create index(:posts, [:user_id])

  end
end

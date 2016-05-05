defmodule Elixirer.Repo.Migrations.CreateNode do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :title, :string
      add :slug, :string
      add :posts_count, :integer

      timestamps
    end

  end
end

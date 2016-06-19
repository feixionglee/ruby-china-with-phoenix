defmodule Elixirer.Repo.Migrations.CreateCommentLike do
  use Ecto.Migration

  def change do
    create table(:comment_likes) do
      add :user_id, references(:users, on_delete: :nothing)
      add :comment_id, references(:comments, on_delete: :nothing)

      timestamps
    end
    create index(:comment_likes, [:user_id])
    create index(:comment_likes, [:comment_id])

  end
end

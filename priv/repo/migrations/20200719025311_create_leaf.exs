defmodule Ashborne.Repo.Migrations.CreateLeaf do
  use Ecto.Migration

  def change do
    create table(:leaf) do
      add :content, :string, null: false
      add :squirrel_id, references(:squirrels, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:leaf, [:squirrel_id])
  end
end

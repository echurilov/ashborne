defmodule Ashborne.Repo.Migrations.CreateSquirrels do
  use Ecto.Migration

  def change do
    create table(:squirrels) do
      add :email, :string, null: false
      add :handle, :string, null: false

      timestamps()
    end

    create unique_index(:squirrels, [:email])
  end
end

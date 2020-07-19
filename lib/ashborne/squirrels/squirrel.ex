defmodule Ashborne.Squirrels.Squirrel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "squirrels" do
    field :email, :string
    field :handle, :string

    timestamps()
  end

  @doc false
  def changeset(squirrel, attrs) do
    squirrel
    |> cast(attrs, [:handle, :email])
    |> validate_required([:handle, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,63}$/)
    |> validate_length(:handle, min: 2)
    |> validate_length(:handle, max: 140)
  end
end

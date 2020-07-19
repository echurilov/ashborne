defmodule Ashborne.Leafs.Leaf do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ashborne.Squirrels.Squirrel

  schema "leaf" do
    field :content, :string
    belongs_to :squirrel, Squirrel

    timestamps()
  end

  @doc false
  def changeset(leaf, attrs) do
    leaf
    |> cast(attrs, [:content, :squirrel_id])
    |> validate_required([:content, :squirrel_id])
    |> foreign_key_constraint(:squirrel_id)
  end
end

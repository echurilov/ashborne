defmodule Ashborne.Leafs do
  @moduledoc """
  The Leafs context.
  """

  import Ecto.Query, warn: false
  alias Ashborne.Repo

  alias Ashborne.Leafs.Leaf

  @doc """
  Returns the list of leaf.

  ## Examples

      iex> list_leaf()
      [%Leaf{}, ...]

  """
  def list_leaf do
    Repo.all(Leaf)
  end

  @doc """
  Gets a single leaf.

  Raises `Ecto.NoResultsError` if the Leaf does not exist.

  ## Examples

      iex> get_leaf!(123)
      %Leaf{}

      iex> get_leaf!(456)
      ** (Ecto.NoResultsError)

  """
  def get_leaf!(id), do: Repo.get!(Leaf, id)

  @doc """
  Creates a leaf.

  ## Examples

      iex> create_leaf(%{field: value})
      {:ok, %Leaf{}}

      iex> create_leaf(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_leaf(attrs \\ %{}) do
    %Leaf{}
    |> Leaf.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a leaf.

  ## Examples

      iex> update_leaf(leaf, %{field: new_value})
      {:ok, %Leaf{}}

      iex> update_leaf(leaf, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_leaf(%Leaf{} = leaf, attrs) do
    leaf
    |> Leaf.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a leaf.

  ## Examples

      iex> delete_leaf(leaf)
      {:ok, %Leaf{}}

      iex> delete_leaf(leaf)
      {:error, %Ecto.Changeset{}}

  """
  def delete_leaf(%Leaf{} = leaf) do
    Repo.delete(leaf)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking leaf changes.

  ## Examples

      iex> change_leaf(leaf)
      %Ecto.Changeset{data: %Leaf{}}

  """
  def change_leaf(%Leaf{} = leaf, attrs \\ %{}) do
    Leaf.changeset(leaf, attrs)
  end
end

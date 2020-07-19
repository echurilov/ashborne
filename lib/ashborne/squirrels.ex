defmodule Ashborne.Squirrels do
  @moduledoc """
  The Squirrels context.
  """

  import Ecto.Query, warn: false
  alias Ashborne.Repo

  alias Ashborne.Squirrels.Squirrel

  @doc """
  Returns the list of squirrels.

  ## Examples

      iex> list_squirrels()
      [%Squirrel{}, ...]

  """
  def list_squirrels do
    Repo.all(Squirrel)
  end

  @doc """
  Gets a single squirrel.

  Raises `Ecto.NoResultsError` if the Squirrel does not exist.

  ## Examples

      iex> get_squirrel!(123)
      %Squirrel{}

      iex> get_squirrel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_squirrel!(id), do: Repo.get!(Squirrel, id)

  @doc """
  Creates a squirrel.

  ## Examples

      iex> create_squirrel(%{field: value})
      {:ok, %Squirrel{}}

      iex> create_squirrel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_squirrel(attrs \\ %{}) do
    %Squirrel{}
    |> Squirrel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a squirrel.

  ## Examples

      iex> update_squirrel(squirrel, %{field: new_value})
      {:ok, %Squirrel{}}

      iex> update_squirrel(squirrel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_squirrel(%Squirrel{} = squirrel, attrs) do
    squirrel
    |> Squirrel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a squirrel.

  ## Examples

      iex> delete_squirrel(squirrel)
      {:ok, %Squirrel{}}

      iex> delete_squirrel(squirrel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_squirrel(%Squirrel{} = squirrel) do
    Repo.delete(squirrel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking squirrel changes.

  ## Examples

      iex> change_squirrel(squirrel)
      %Ecto.Changeset{data: %Squirrel{}}

  """
  def change_squirrel(%Squirrel{} = squirrel, attrs \\ %{}) do
    Squirrel.changeset(squirrel, attrs)
  end
end

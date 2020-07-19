defmodule AshborneWeb.LeafController do
  use AshborneWeb, :controller

  alias Ashborne.Leafs
  alias Ashborne.Leafs.Leaf

  def index(conn, _params) do
    leaf = Leafs.list_leaf()
    render(conn, "index.html", leaf: leaf)
  end

  def new(conn, _params) do
    changeset = Leafs.change_leaf(%Leaf{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"leaf" => leaf_params}) do
    case Leafs.create_leaf(leaf_params) do
      {:ok, leaf} ->
        conn
        |> put_flash(:info, "Leaf created successfully.")
        |> redirect(to: Routes.leaf_path(conn, :show, leaf))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    leaf = Leafs.get_leaf!(id)
    render(conn, "show.html", leaf: leaf)
  end

  def edit(conn, %{"id" => id}) do
    leaf = Leafs.get_leaf!(id)
    changeset = Leafs.change_leaf(leaf)
    render(conn, "edit.html", leaf: leaf, changeset: changeset)
  end

  def update(conn, %{"id" => id, "leaf" => leaf_params}) do
    leaf = Leafs.get_leaf!(id)

    case Leafs.update_leaf(leaf, leaf_params) do
      {:ok, leaf} ->
        conn
        |> put_flash(:info, "Leaf updated successfully.")
        |> redirect(to: Routes.leaf_path(conn, :show, leaf))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", leaf: leaf, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    leaf = Leafs.get_leaf!(id)
    {:ok, _leaf} = Leafs.delete_leaf(leaf)

    conn
    |> put_flash(:info, "Leaf deleted successfully.")
    |> redirect(to: Routes.leaf_path(conn, :index))
  end
end

defmodule AshborneWeb.SquirrelController do
  use AshborneWeb, :controller

  alias Ashborne.Squirrels
  alias Ashborne.Squirrels.Squirrel

  def index(conn, _params) do
    squirrels = Squirrels.list_squirrels()
    render(conn, "index.html", squirrels: squirrels)
  end

  def new(conn, _params) do
    changeset = Squirrels.change_squirrel(%Squirrel{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"squirrel" => squirrel_params}) do
    case Squirrels.create_squirrel(squirrel_params) do
      {:ok, squirrel} ->
        conn
        |> put_flash(:info, "Squirrel created successfully.")
        |> redirect(to: Routes.squirrel_path(conn, :show, squirrel))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    squirrel = Squirrels.get_squirrel!(id)
    render(conn, "show.html", squirrel: squirrel)
  end

  def edit(conn, %{"id" => id}) do
    squirrel = Squirrels.get_squirrel!(id)
    changeset = Squirrels.change_squirrel(squirrel)
    render(conn, "edit.html", squirrel: squirrel, changeset: changeset)
  end

  def update(conn, %{"id" => id, "squirrel" => squirrel_params}) do
    squirrel = Squirrels.get_squirrel!(id)

    case Squirrels.update_squirrel(squirrel, squirrel_params) do
      {:ok, squirrel} ->
        conn
        |> put_flash(:info, "Squirrel updated successfully.")
        |> redirect(to: Routes.squirrel_path(conn, :show, squirrel))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", squirrel: squirrel, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    squirrel = Squirrels.get_squirrel!(id)
    {:ok, _squirrel} = Squirrels.delete_squirrel(squirrel)

    conn
    |> put_flash(:info, "Squirrel deleted successfully.")
    |> redirect(to: Routes.squirrel_path(conn, :index))
  end
end

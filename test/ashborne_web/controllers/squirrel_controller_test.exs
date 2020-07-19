defmodule AshborneWeb.SquirrelControllerTest do
  use AshborneWeb.ConnCase

  alias Ashborne.Squirrels

  @create_attrs %{handle: "some handle", email: "email@example.com"}
  @update_attrs %{handle: "some updated handle", email: "email@example.org"}
  @invalid_attrs %{handle: nil, email: nil}

  def fixture(:squirrel) do
    {:ok, squirrel} = Squirrels.create_squirrel(@create_attrs)
    squirrel
  end

  describe "index" do
    test "lists all squirrels", %{conn: conn} do
      conn = get(conn, Routes.squirrel_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Squirrels"
    end
  end

  describe "new squirrel" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.squirrel_path(conn, :new))
      assert html_response(conn, 200) =~ "New Squirrel"
    end
  end

  describe "create squirrel" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.squirrel_path(conn, :create), squirrel: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.squirrel_path(conn, :show, id)

      conn = get(conn, Routes.squirrel_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Squirrel"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.squirrel_path(conn, :create), squirrel: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Squirrel"
    end
  end

  describe "edit squirrel" do
    setup [:create_squirrel]

    test "renders form for editing chosen squirrel", %{conn: conn, squirrel: squirrel} do
      conn = get(conn, Routes.squirrel_path(conn, :edit, squirrel))
      assert html_response(conn, 200) =~ "Edit Squirrel"
    end
  end

  describe "update squirrel" do
    setup [:create_squirrel]

    test "redirects when data is valid", %{conn: conn, squirrel: squirrel} do
      conn = put(conn, Routes.squirrel_path(conn, :update, squirrel), squirrel: @update_attrs)
      assert redirected_to(conn) == Routes.squirrel_path(conn, :show, squirrel)

      conn = get(conn, Routes.squirrel_path(conn, :show, squirrel))
      assert html_response(conn, 200) =~ "some updated handle"
    end

    test "renders errors when data is invalid", %{conn: conn, squirrel: squirrel} do
      conn = put(conn, Routes.squirrel_path(conn, :update, squirrel), squirrel: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Squirrel"
    end
  end

  describe "delete squirrel" do
    setup [:create_squirrel]

    test "deletes chosen squirrel", %{conn: conn, squirrel: squirrel} do
      conn = delete(conn, Routes.squirrel_path(conn, :delete, squirrel))
      assert redirected_to(conn) == Routes.squirrel_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.squirrel_path(conn, :show, squirrel))
      end
    end
  end

  defp create_squirrel(_) do
    squirrel = fixture(:squirrel)
    %{squirrel: squirrel}
  end
end

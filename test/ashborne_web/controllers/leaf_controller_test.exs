defmodule AshborneWeb.LeafControllerTest do
  use AshborneWeb.ConnCase

  alias Ashborne.Leafs
  alias Ashborne.Squirrels

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  def fixture(:leaf) do    
    create_attrs = add_squirrel_id(@create_attrs)

    {:ok, leaf} = Leafs.create_leaf(create_attrs)
    leaf
  end

  describe "index" do
    test "lists all leaf", %{conn: conn} do
      conn = get(conn, Routes.leaf_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Leaf"
    end
  end

  describe "new leaf" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.leaf_path(conn, :new))
      assert html_response(conn, 200) =~ "New Leaf"
    end
  end

  describe "create leaf" do
    test "redirects to show when data is valid", %{conn: conn} do
      create_attrs = add_squirrel_id(@create_attrs)

      conn = post(conn, Routes.leaf_path(conn, :create), leaf: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.leaf_path(conn, :show, id)

      conn = get(conn, Routes.leaf_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Leaf"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.leaf_path(conn, :create), leaf: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Leaf"
    end
  end

  describe "edit leaf" do
    setup [:create_leaf]

    test "renders form for editing chosen leaf", %{conn: conn, leaf: leaf} do
      conn = get(conn, Routes.leaf_path(conn, :edit, leaf))
      assert html_response(conn, 200) =~ "Edit Leaf"
    end
  end

  describe "update leaf" do
    setup [:create_leaf]

    test "redirects when data is valid", %{conn: conn, leaf: leaf} do
      conn = put(conn, Routes.leaf_path(conn, :update, leaf), leaf: @update_attrs)
      assert redirected_to(conn) == Routes.leaf_path(conn, :show, leaf)

      conn = get(conn, Routes.leaf_path(conn, :show, leaf))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, leaf: leaf} do
      conn = put(conn, Routes.leaf_path(conn, :update, leaf), leaf: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Leaf"
    end
  end

  describe "delete leaf" do
    setup [:create_leaf]

    test "deletes chosen leaf", %{conn: conn, leaf: leaf} do
      conn = delete(conn, Routes.leaf_path(conn, :delete, leaf))
      assert redirected_to(conn) == Routes.leaf_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.leaf_path(conn, :show, leaf))
      end
    end
  end

  defp create_leaf(_) do
    leaf = fixture(:leaf)
    %{leaf: leaf}
  end

  defp add_squirrel_id(attrs) do
    time = System.os_time(:second)

    squirrel_attrs = %{handle: "#{time}", email: "#{time}@example.com"}
    {:ok, squirrel} = Squirrels.create_squirrel(squirrel_attrs)
    
    attrs_with_id =
      attrs
      |> Map.put(:squirrel_id, squirrel.id)
    
    attrs_with_id
  end
end

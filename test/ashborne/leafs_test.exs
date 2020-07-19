defmodule Ashborne.LeafsTest do
  use Ashborne.DataCase

  alias Ashborne.Squirrels
  alias Ashborne.Leafs

  describe "leaf" do
    alias Ashborne.Leafs.Leaf

    @testSquirrel_attrs %{handle: "some handle", email: "email@example.com"}

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def leaf_fixture(attrs \\ %{}) do
      {:ok, squirrel} = Squirrels.create_squirrel(@testSquirrel_attrs)
      
      valid_attrs = 
        @valid_attrs
        |> Map.put(:squirrel_id, squirrel.id)

      {:ok, leaf} =
        attrs
        |> Enum.into(valid_attrs)
        |> Leafs.create_leaf()

      leaf
    end

    test "list_leaf/0 returns all leaf" do
      leaf = leaf_fixture()
      assert Leafs.list_leaf() == [leaf]
    end

    test "get_leaf!/1 returns the leaf with given id" do
      leaf = leaf_fixture()
      assert Leafs.get_leaf!(leaf.id) == leaf
    end

    test "create_leaf/1 with valid data creates a leaf" do
      {:ok, squirrel} = Squirrels.create_squirrel(@testSquirrel_attrs)

      valid_attrs = 
        @valid_attrs
        |> Map.put(:squirrel_id, squirrel.id)

      assert {:ok, %Leaf{} = leaf} = Leafs.create_leaf(valid_attrs)
      assert leaf.content == "some content"
    end

    test "create_leaf/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Leafs.create_leaf(@invalid_attrs)
    end

    test "update_leaf/2 with valid data updates the leaf" do
      leaf = leaf_fixture()
      assert {:ok, %Leaf{} = leaf} = Leafs.update_leaf(leaf, @update_attrs)
      assert leaf.content == "some updated content"
    end

    test "update_leaf/2 with invalid data returns error changeset" do
      leaf = leaf_fixture()
      assert {:error, %Ecto.Changeset{}} = Leafs.update_leaf(leaf, @invalid_attrs)
      assert leaf == Leafs.get_leaf!(leaf.id)
    end

    test "delete_leaf/1 deletes the leaf" do
      leaf = leaf_fixture()
      assert {:ok, %Leaf{}} = Leafs.delete_leaf(leaf)
      assert_raise Ecto.NoResultsError, fn -> Leafs.get_leaf!(leaf.id) end
    end

    test "change_leaf/1 returns a leaf changeset" do
      leaf = leaf_fixture()
      assert %Ecto.Changeset{} = Leafs.change_leaf(leaf)
    end
  end
end

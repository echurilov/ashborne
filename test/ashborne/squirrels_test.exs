defmodule Ashborne.SquirrelsTest do
  use Ashborne.DataCase

  alias Ashborne.Squirrels

  describe "squirrels" do
    alias Ashborne.Squirrels.Squirrel

    @valid_attrs %{handle: "some handle", email: "email@example.com"}
    @update_attrs %{handle: "some updated handle", email: "email@example.org"}
    @invalid_attrs %{handle: nil, email: nil}

    def squirrel_fixture(attrs \\ %{}) do
      {:ok, squirrel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Squirrels.create_squirrel()

      squirrel
    end

    test "list_squirrels/0 returns all squirrels" do
      squirrel = squirrel_fixture()
      assert Squirrels.list_squirrels() == [squirrel]
    end

    test "get_squirrel!/1 returns the squirrel with given id" do
      squirrel = squirrel_fixture()
      assert Squirrels.get_squirrel!(squirrel.id) == squirrel
    end

    test "create_squirrel/1 with valid data creates a squirrel" do
      assert {:ok, %Squirrel{} = squirrel} = Squirrels.create_squirrel(@valid_attrs)
      assert squirrel.handle == "some handle"
      assert squirrel.email == "email@example.com"
    end

    test "create_squirrel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Squirrels.create_squirrel(@invalid_attrs)
    end

    test "update_squirrel/2 with valid data updates the squirrel" do
      squirrel = squirrel_fixture()
      assert {:ok, %Squirrel{} = squirrel} = Squirrels.update_squirrel(squirrel, @update_attrs)
      assert squirrel.handle == "some updated handle"
      assert squirrel.email == "email@example.org"
    end

    test "update_squirrel/2 with invalid data returns error changeset" do
      squirrel = squirrel_fixture()
      assert {:error, %Ecto.Changeset{}} = Squirrels.update_squirrel(squirrel, @invalid_attrs)
      assert squirrel == Squirrels.get_squirrel!(squirrel.id)
    end

    test "delete_squirrel/1 deletes the squirrel" do
      squirrel = squirrel_fixture()
      assert {:ok, %Squirrel{}} = Squirrels.delete_squirrel(squirrel)
      assert_raise Ecto.NoResultsError, fn -> Squirrels.get_squirrel!(squirrel.id) end
    end

    test "change_squirrel/1 returns a squirrel changeset" do
      squirrel = squirrel_fixture()
      assert %Ecto.Changeset{} = Squirrels.change_squirrel(squirrel)
    end
  end
end

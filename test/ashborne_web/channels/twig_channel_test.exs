defmodule AshborneWeb.TwigChannelTest do
  use AshborneWeb.ChannelCase
  alias Ashborne.Leafs

  setup do
    {:ok, _, socket} =
      AshborneWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(AshborneWeb.TwigChannel, "twig:nest")

    %{socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to twig:nest", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end

  test ":after_join shows all existing leafs", %{socket: socket} do
    payload = %{squirrel_id: 1, content: "test"}
    Leafs.create_leaf(payload)
  
    {:ok, _, socket2} = AshborneWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(AshborneWeb.TwigChannel, "twig:nest")
  
    assert socket2.join_ref != socket.join_ref
  end
end

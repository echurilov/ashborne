defmodule AshborneWeb.TwigChannel do
  use AshborneWeb, :channel
  alias Ashborne.Leafs

  @impl true
  def join("twig:nest", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (twig:nest).
  @impl true
  def handle_in("shout", payload, socket) do
    Leafs.create_leaf(payload)
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    Leafs.list_leaf()
    |> Enum.each(fn leaf -> push(socket, "shout", %{
        squirrel_id: leaf.squirrel_id,
        content: leaf.content,
      }) end)
    {:noreply, socket} # :noreply
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

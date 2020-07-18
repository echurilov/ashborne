defmodule AshborneWeb.PageController do
  use AshborneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

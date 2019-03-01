defmodule PhoenixElmBoilerplateWeb.PageController do
  use PhoenixElmBoilerplateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule ElmSpaWeb.PageController do
  use ElmSpaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

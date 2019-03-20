defmodule ElmSpaWeb.Router do
  use ElmSpaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElmSpaWeb do
    pipe_through :browser
    get("/*path", PageController, :index)

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ElmSpaWeb do
    pipe_through :api
    get "/notes", NotesController, :index
  end
end

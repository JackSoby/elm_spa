defmodule ElmSpaWeb.NoteController do
  use ElmSpaWeb, :controller
  alias ElmSpa.Notes
  require IEx

  def index(conn, _params) do
    notes = Notes.list_notes()
    IEx.pry()
    render(conn, "index.json", notes: notes)
  end
end

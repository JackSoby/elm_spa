defmodule ElmSpaWeb.NoteView do
  use ElmSpaWeb, :view

  def render("index.json", %{notes: notes}) do
    %{data: render_many(notes, NoteView, "note.json")}
  end

  def render("note.json", %{note: note}) do
    %{
      note: note.id,
      name: note.name,
      body: note.body
    }
  end
end

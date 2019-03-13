defmodule ElmSpa.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :name, :string
      add :body, :string

      timestamps()
    end

  end
end

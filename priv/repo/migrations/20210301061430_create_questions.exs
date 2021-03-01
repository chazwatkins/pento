defmodule Pento.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :answer, :string
      add :vote_count, :integer, default: 0

      timestamps()
    end

    create unique_index(:questions, [:question])
  end
end

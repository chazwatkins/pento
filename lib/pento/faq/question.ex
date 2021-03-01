defmodule Pento.FAQ.Question do
  use Pento.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answer, :string
    field :question, :string
    field :vote_count, :integer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :answer, :vote_count])
    |> validate_required([:question, :answer])
    |> unique_constraint(:question)
  end

  def upvote_changeset(question, attrs) do
    question
    |> cast(attrs, [:vote_count])
    |> validate_number(:vote_count, greater_than: question.vote_count)
  end
end

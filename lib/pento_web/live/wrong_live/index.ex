defmodule PentoWeb.WrongLive.Index do
  use PentoWeb, :live_view

  @answer_range 1..10

  def mount(_params, session, socket) do
    socket =
      socket
      |> assign_defaults()
      |> assign(user: Pento.Accounts.get_user_by_session_token(session["user_token"]))
      |> assign(session_id: session["live_socket_id"])

    {:ok, assign_defaults(socket)}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    socket =
      socket
      |> check_guess(guess)
      |> generate_message(guess)
      |> calculate_score()

    {:noreply, socket}
  end

  def handle_event("continue", _params, socket) do
    socket =
      socket
      |> assign_defaults()
      |> assign(score: socket.assigns.score)

    {:noreply, socket}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, assign_defaults(socket)}
  end

  defp assign_defaults(socket) do
    assign(
      socket,
      score: 0,
      message: "Guess a number.",
      answer_range: @answer_range,
      answer: generate_answer(),
      guess_correct: false
    )
  end

  defp check_guess(socket, guess) do
    assign(
      socket,
      guess_correct:
        guess_correct?(
          guess,
          socket.assigns.answer
        )
    )
  end

  defp guess_correct?(guess, answer), do: String.to_integer(guess) == answer

  defp generate_answer() do
    Enum.random(@answer_range)
  end

  defp generate_message(socket, guess) do
    message =
      if socket.assigns.guess_correct do
        "Correct. WooHoo!"
      else
        "Wrong. Guess again."
      end

    assign(socket, message: "Your guess: #{guess}. #{message}")
  end

  defp calculate_score(socket) do
    score =
      if socket.assigns.guess_correct do
        socket.assigns.score + 100
      else
        socket.assigns.score - 1
      end

    assign(socket, score: score)
  end
end

defmodule PentoWeb.PromoLive.Index do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_recipient()
      |> assign_changeset()

    {:ok, socket}
  end

  def assign_recipient(socket) do
    assign(socket, recipient: %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    assign(socket, changeset: Promo.change_recipient(recipient))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"recipient" => _recipient_params}, socket) do
    :timer.sleep(1000)
    {:noreply, socket}
  end
end

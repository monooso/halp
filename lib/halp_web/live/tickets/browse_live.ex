defmodule HalpWeb.Tickets.BrowseLive do
  use HalpWeb, :live_view
  alias Halp.Tickets

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_tickets() |> assign_page_title()}
  end

  defp assign_page_title(socket), do: assign(socket, :page_title, "Tickets")

  defp assign_tickets(socket), do: assign(socket, :tickets, Tickets.list_tickets())
end

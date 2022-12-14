defmodule HalpWeb.Tickets.AddLive do
  use HalpWeb, :live_view
  alias Halp.Tickets
  alias Halp.Tickets.Ticket

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_changeset()
     |> assign_priorities()
     |> assign_page_title()}
  end

  @impl true
  def handle_event("save", %{"ticket" => params}, socket) do
    params = params |> Map.put("status", :pending)

    case Tickets.create_ticket(params) do
      {:ok, _ticket} -> handle_success(socket)
      {:error, changeset} -> handle_failure(socket, changeset)
    end
  end

  defp assign_changeset(socket), do: assign(socket, :changeset, Tickets.create_ticket_changeset())

  defp assign_page_title(socket), do: assign(socket, :page_title, "Create Ticket")

  defp assign_priorities(socket) do
    priorities =
      Ticket
      |> Ecto.Enum.mappings(:priority)
      |> Enum.map(fn {atom, _index} -> {atom |> Atom.to_string() |> String.capitalize(), atom} end)

    assign(socket, :priorities, priorities)
  end

  defp handle_failure(socket, changeset), do: {:noreply, socket |> assign(:changeset, changeset)}

  defp handle_success(socket) do
    {:noreply,
     socket
     |> put_flash(:info, "Ticket created successfully.")
     |> redirect(to: ~p"/tickets")}
  end
end

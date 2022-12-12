defmodule Halp.Tickets do
  @moduledoc false

  import Ecto.Query, warn: false
  alias Halp.Repo
  alias Halp.Tickets.Ticket

  @doc """
  Returns the list of tickets.
  """
  def list_tickets, do: Repo.all(Ticket)

  @doc """
  Gets a single ticket.
  """
  def get_ticket!(id), do: Repo.get!(Ticket, id)

  @doc """
  Creates a ticket.
  """
  def create_ticket(attrs \\ %{}), do: create_ticket_changeset(attrs) |> Repo.insert()

  @doc """
  Returns a changeset for use when creating a ticket.
  """
  def create_ticket_changeset(attrs \\ %{}), do: Ticket.insert_changeset(attrs)
end

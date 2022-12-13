defmodule Halp.TicketsTest do
  use Halp.DataCase
  import Halp.Factory
  alias Halp.Tickets
  alias Halp.Tickets.Ticket

  describe "create_ticket/1" do
    test "it returns an {:ok, %Ticket{}} tuple when given valid data" do
      attrs = %{
        assignee_id: insert(:user) |> Map.get(:id),
        customer_email: "alan.alda@mash.com",
        customer_name: "Alan Alda",
        priority: :medium,
        status: :pending,
        subject: "I need help!"
      }

      assert {:ok, %Ticket{}} = Tickets.create_ticket(attrs)
    end

    test "it returns an {:error, %Ecto.Changeset{}} tuple when given invalid data" do
      assert {:error, %Ecto.Changeset{}} = Tickets.create_ticket()
    end
  end

  describe "create_ticket_changeset/1" do
    test "it returns a changeset for the %Ticket{} struct" do
      assert %Ecto.Changeset{data: %Ticket{}} = Tickets.create_ticket_changeset()
    end
  end

  describe "get_ticket!/1" do
    test "it returns the %Ticket{} struct identified by the given id" do
      %{id: expected_id} = insert(:ticket)

      assert %Ticket{id: ^expected_id} = Tickets.get_ticket!(expected_id)
    end

    test "it raises if the given id does not exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Tickets.get_ticket!(Ecto.UUID.generate())
      end
    end
  end

  describe "list_tickets/0" do
    test "it lists all of the tickets" do
      normalize = fn %{id: id} -> %Ticket{id: id} end

      tickets = insert_list(3, :ticket) |> Enum.map(normalize)

      assert ^tickets = Tickets.list_tickets() |> Enum.map(normalize)
    end
  end
end

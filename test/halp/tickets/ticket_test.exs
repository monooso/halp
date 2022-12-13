defmodule Halp.Tickets.TicketTest do
  use Halp.DataCase
  import Halp.Factory
  alias Ecto.Changeset
  alias Halp.Tickets.Ticket

  describe "insert_changeset/1" do
    setup do
      [
        valid_attrs: %{
          assignee_id: insert(:user) |> Map.get(:id),
          customer_email: "alan.alda@example.com",
          customer_name: "Alan Alda",
          status: :pending,
          subject: "I need help!",
          priority: :medium
        }
      ]
    end

    test "it returns a changeset for the %Ticket{} struct", %{valid_attrs: attrs} do
      assert %Changeset{data: %Ticket{}} = Ticket.insert_changeset(attrs)
    end

    test "it returns a valid changeset when given valid data", %{valid_attrs: attrs} do
      assert %Changeset{valid?: true} = Ticket.insert_changeset(attrs)
    end

    test "it returns a invalid changeset when given invalid data" do
      assert %Changeset{valid?: false} = Ticket.insert_changeset(%{})
    end

    test "it does not require an assignee_id", %{valid_attrs: attrs} do
      attrs = Map.delete(attrs, :assignee_id)

      assert %Changeset{valid?: true} = Ticket.insert_changeset(attrs)
    end

    test "if assignee_id is present, it must refer to a known user", %{valid_attrs: attrs} do
      attrs = %{attrs | assignee_id: Ecto.UUID.generate()}

      {:error, changeset} = Ticket.insert_changeset(attrs) |> Halp.Repo.insert()

      assert %{assignee: ["does not exist"]} = errors_on(changeset)
    end

    test "it requires a customer_email", %{valid_attrs: attrs} do
      attrs = Map.delete(attrs, :customer_email)

      changeset = Ticket.insert_changeset(attrs)

      assert %{customer_email: ["can't be blank"]} = errors_on(changeset)
    end

    test "customer_email must contain an @ symbol", %{valid_attrs: attrs} do
      attrs = %{attrs | customer_email: "nope.com"}

      changeset = Ticket.insert_changeset(attrs)

      assert %{customer_email: ["must be a valid email"]} = errors_on(changeset)
    end

    test "customer_email must be at most 255 characters long", %{valid_attrs: attrs} do
      attrs = %{attrs | customer_email: String.pad_leading("a@b.com", 256, "a")}

      changeset = Ticket.insert_changeset(attrs)

      assert %{customer_email: ["should be at most 255 character(s)"]} = errors_on(changeset)
    end

    test "it requires a customer_name", %{valid_attrs: attrs} do
      attrs = Map.delete(attrs, :customer_name)

      changeset = Ticket.insert_changeset(attrs)

      assert %{customer_name: ["can't be blank"]} = errors_on(changeset)
    end

    test "customer_name must be at least two characters long", %{valid_attrs: attrs} do
      attrs = %{attrs | customer_name: "A"}

      changeset = Ticket.insert_changeset(attrs)

      assert %{customer_name: ["should be at least 2 character(s)"]} = errors_on(changeset)
    end

    test "customer_name must be at most 255 characters long", %{valid_attrs: attrs} do
      attrs = %{attrs | customer_name: String.pad_leading("", 256, "x")}

      changeset = Ticket.insert_changeset(attrs)

      assert %{customer_name: ["should be at most 255 character(s)"]} = errors_on(changeset)
    end

    test "it requires a status", %{valid_attrs: attrs} do
      attrs = Map.delete(attrs, :status)

      changeset = Ticket.insert_changeset(attrs)

      assert %{status: ["can't be blank"]} = errors_on(changeset)
    end

    test "status must be a known value", %{valid_attrs: attrs} do
      attrs = %{attrs | status: :nope}

      changeset = Ticket.insert_changeset(attrs)

      assert %{status: ["is invalid"]} = errors_on(changeset)
    end

    test "it requires a subject", %{valid_attrs: attrs} do
      attrs = Map.delete(attrs, :subject)

      changeset = Ticket.insert_changeset(attrs)

      assert %{subject: ["can't be blank"]} = errors_on(changeset)
    end

    test "subject must be at least two characters", %{valid_attrs: attrs} do
      attrs = %{attrs | subject: "A"}

      changeset = Ticket.insert_changeset(attrs)

      assert %{subject: ["should be at least 2 character(s)"]} = errors_on(changeset)
    end

    test "subject must be at most 255 characters", %{valid_attrs: attrs} do
      attrs = %{attrs | subject: String.pad_leading("", 256, "x")}

      changeset = Ticket.insert_changeset(attrs)

      assert %{subject: ["should be at most 255 character(s)"]} = errors_on(changeset)
    end

    test "it requires a priority", %{valid_attrs: attrs} do
      attrs = Map.delete(attrs, :priority)

      changeset = Ticket.insert_changeset(attrs)

      assert %{priority: ["can't be blank"]} = errors_on(changeset)
    end

    test "priority must be a known value", %{valid_attrs: attrs} do
      attrs = %{attrs | priority: :nope}

      changeset = Ticket.insert_changeset(attrs)

      assert %{priority: ["is invalid"]} = errors_on(changeset)
    end
  end
end

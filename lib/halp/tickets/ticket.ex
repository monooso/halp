defmodule Halp.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Halp.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tickets" do
    field :customer_email, :string
    field :customer_name, :string
    field :message, :string
    field :priority, Ecto.Enum, values: [low: 1, medium: 2, high: 3, urgent: 4]
    field :status, Ecto.Enum, values: [:closed, :on_hold, :open, :pending, :solved, :spam]
    field :subject, :string

    belongs_to :assignee, User, foreign_key: :assignee_id

    timestamps()
  end

  @doc """
  Returns a changeset for use when creating a ticket.
  """
  def insert_changeset(attrs) do
    required_attrs = [:customer_email, :customer_name, :message, :status, :subject, :priority]
    optional_attrs = [:assignee_id]

    %__MODULE__{}
    |> cast(attrs, optional_attrs ++ required_attrs)
    |> validate_required(required_attrs)
    |> validate_customer_email()
    |> validate_customer_name()
    |> validate_subject()
    |> validate_message()
    |> assoc_constraint(:assignee)
  end

  defp validate_customer_email(changeset) do
    changeset
    |> validate_format(:customer_email, ~r/@/, message: "must be a valid email")
    |> validate_length(:customer_email, max: 255)
  end

  defp validate_customer_name(changeset) do
    validate_length(changeset, :customer_name, min: 2, max: 255)
  end

  defp validate_message(changeset) do
    validate_length(changeset, :message, min: 2)
  end

  defp validate_subject(changeset) do
    validate_length(changeset, :subject, min: 2, max: 255)
  end
end

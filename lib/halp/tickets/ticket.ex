defmodule Halp.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias Halp.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tickets" do
    field :customer_email, :string
    field :customer_name, :string
    field :status, Ecto.Enum, values: [:closed, :on_hold, :open, :pending, :solved, :spam]

    belongs_to :assignee, User, foreign_key: :assignee_id

    timestamps()
  end

  @doc false
  def insert_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:status, :customer_email, :customer_name])
    |> validate_required([:status, :customer_email, :customer_name])
  end
end

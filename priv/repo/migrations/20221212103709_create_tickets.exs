defmodule Halp.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :assignee_id, references(:users, type: :binary_id)
      add :subject, :string, null: false
      add :message, :text, null: false
      add :status, :string, null: false
      add :priority, :integer, null: false, default: 1
      add :customer_email, :string, null: false
      add :customer_name, :string, null: false

      timestamps()
    end

    create index(:tickets, [:assignee_id])
    create index(:tickets, [:customer_email])
    create index(:tickets, [:priority])
    create index(:tickets, [:status])
  end
end

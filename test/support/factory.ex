defmodule Halp.Factory do
  use ExMachina.Ecto, repo: Halp.Repo

  def ticket_factory do
    %Halp.Tickets.Ticket{
      assignee: build(:user),
      customer_email: sequence(:customer_email, &"customer-#{&1}@example.com"),
      customer_name: sequence(:customer_name, &"Example Customer #{&1}"),
      priority: sequence(:priority, [:low, :medium, :high, :urgent]),
      status: sequence(:status, [:closed, :on_hold, :open, :pending, :solved, :spam]),
      subject: sequence(:subject, &"Example Subject #{&1}")
    }
  end

  def user_factory do
    %Halp.Accounts.User{
      email: sequence(:email, &"user-#{&1}@example.com"),
      hashed_password: fn user ->
        Bcrypt.hash_pwd_salt(user.password)
      end,
      password: "some-awesome-password"
    }
  end
end

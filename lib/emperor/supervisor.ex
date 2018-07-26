defmodule Emperor.Supervisor do
  use Supervisor

  def start_link do
    IO.puts "😎 Starting the Supervisor"
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__ )
  end

  def init(:ok) do
    children = [
      Emperor.Starter
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

end

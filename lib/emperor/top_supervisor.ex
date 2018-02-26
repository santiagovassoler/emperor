defmodule Emperor.TopSupervisor do
  use Supervisor

  def start_link do
    IO.puts "Starting TOP Supervisor..."
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__ )
  end

  def init(:ok) do
    children = [
      Emperor.Supervisor
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end

end

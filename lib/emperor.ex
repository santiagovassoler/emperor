defmodule Emperor do
use Application

  def start(_type, _args) do
    IO.puts "Starting the application..."
    Emperor.TopSupervisor.start_link()
  end
end

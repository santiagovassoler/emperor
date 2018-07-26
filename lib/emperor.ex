defmodule Emperor do
use Application
  def start(_type, _args) do
    IO.puts " \n\n Starting the application...\n\n"
    Emperor.Supervisor.start_link()
  end
end

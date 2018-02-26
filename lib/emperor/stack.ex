defmodule Stack do
  use GenServer

  def start_link(state, opts \\[]) do
    GenServer.start_link(__MODULE__, [state], name: __MODULE__)
  end

  def pop, do: GenServer.call(__MODULE__, :pop)

  def push(item), do: GenServer.cast(__MODULE__, {:push, item})

  #callbacks
  def handle_call(:pop, _from , [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

end

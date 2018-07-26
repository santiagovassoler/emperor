defmodule Emperor.HttpServer do

  def start(port) when is_integer(port) and port > 1023 do
    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :raw, active: false, reuseaddr: true])
    IO.puts "\n🐧 Emperor is listening for connection requests on port #{port}...\n"
    accept_loop(listen_socket)
  end

  def accept_loop(listen_socket) do
    IO.puts "⏲  Waiting to accept a client connection \n"
    {:ok, client_socket} = :gen_tcp.accept(listen_socket)
    IO.puts "🕵🏻 📞 Connection accepted!\n"
    spawn(fn -> serve(client_socket) end)
    accept_loop(listen_socket)
  end

  def serve(client_socket) do
    IO.puts "#{inspect self()}: <--- 😙 🛠 Working on process!"
    client_socket
    |> read_request
    |> Emperor.Handler.handle
    |> write_response(client_socket)
  end

  def read_request(client_socket) do
    case :gen_tcp.recv(client_socket, 0) do
      {:ok, request} ->
        request
      {:error, _} ->
        exit(:normal)
    end
  end

  def write_response(response, client_socket) do
    :ok = :gen_tcp.send(client_socket, response)
    IO.puts "📬 Sent response:\n"
    IO.puts response
    :gen_tcp.close(client_socket)
  end

end

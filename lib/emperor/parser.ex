defmodule Emperor.Parser do

  alias Emperor.Conv

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

      %Conv{
         method: method,
         path: path
       }
  end
end

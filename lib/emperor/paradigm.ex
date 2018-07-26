defmodule Emperor.Paradigm do
  alias Emperor.Language

  def list_languages do
    [
      %Language{id: 1, name: "Elixir", type: "functional"},
      %Language{id: 2, name: "Erlang", type: "funtional"},
      %Language{id: 3, name: "Java", type: "object oriented"},
      %Language{id: 4, name: "C", type: "imperative"},
      %Language{id: 5, name: "C++", type: "object oriented"},
      %Language{id: 6, name: "Python", type: "multi paradigm"},
      %Language{id: 7, name: "Ruby", type: "object oriented"},
      %Language{id: 8, name: "PHP", type: "object oriented"},
      %Language{id: 9, name: "Scala", type: "functional"},
      %Language{id: 10, name: "Haskel", type: "functional"}
    ]
  end

  def get_language(id) when is_integer(id) do
     Enum.find(list_languages(), fn(b) -> b.id == id end)
  end

  def get_language(id) when is_binary(id) do
    id |> String.to_integer |> get_language
  end
end

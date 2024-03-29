defmodule ParserTest do
  use ExUnit.Case
  doctest Emperor.Parser

  alias Emperor.Parser

  test "parses a list of header fields into a map" do
    header_lines = ["a: 1", "b: 2"]

    headers = Parser.parse_headers(header_lines, %{})

    assert headers == %{"a" => "1", "b" => "2"}
  end
end

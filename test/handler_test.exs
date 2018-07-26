defmodule HandlerTest do
  use ExUnit.Case

  import Emperor.Handler, only: [handle: 1]

  test "GET /helloworld" do
    request = """
    GET /helloworld HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 200 OK\r
    content-type: text/html\r
    content-length: 11\r
    \r
    Hello World
    """
  end

  test "GET /languages" do
    request = """
    GET /languages HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    content-type: text/html\r
    content-length: 411\r
    \r
    <h1>All The Languages!</h1>
    <ul>
    <li>C - imperative</li>
    <li>C++ - object oriented</li>
    <li>Elixir - functional</li>
    <li>Erlang - funtional</li>
    <li>Haskel - functional</li>
    <li>Java - object oriented</li>
    <li>PHP - object oriented</li>
    <li>Python - multi paradigm</li>
    <li>Ruby - object oriented</li>
    <li>Scala - functional</li>
    </ul>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  test "GET /bigfoot" do
    request = """
    GET /javascript HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response == """
    HTTP/1.1 404 Not Found\r
    content-type: text/html\r
    content-length: 44\r
    \r
    <h1>404</h1><br>Sorry /javascript not found!
    """
  end

  test "GET /languages/1" do
    request = """
    GET /languages/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    expected_response = """
    HTTP/1.1 200 OK\r
    content-type: text/html\r
    content-length: 49\r
    \r
    <h1>Show Language</h1>
    <p>
    <h1> Elixir<h1>
    </p>
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end


  test "DELETE /languages" do
  request = """
  DELETE /languages/1 HTTP/1.1\r
  Host: example.com\r
  User-Agent: ExampleBrowser/1.0\r
  Accept: */*\r
  \r
  """

  response = handle(request)

  assert response == """
  HTTP/1.1 403 Forbidden\r
  content-type: text/html\r
  content-length: 32\r
  \r
  Deleting this item is forbidden!
  """
end
test "GET /api/languages" do
  request = """
  GET /api/languages HTTP/1.1\r
  Host: example.com\r
  User-Agent: ExampleBrowser/1.0\r
  Accept: */*\r
  \r
  """

  response = handle(request)

  expected_response = """
  HTTP/1.1 200 OK\r
  content-type: application/json\r
  content-length: 459\r
  \r
  [{"type":"functional","name":"Elixir","id":1},
  {"type":"funtional","name":"Erlang","id":2},
  {"type":"object oriented","name":"Java","id":3},
  {"type":"imperative","name":"C","id":4},
  {"type":"object oriented","name":"C++","id":5},
  {"type":"multi paradigm","name":"Python","id":6},
  {"type":"object oriented","name":"Ruby","id":7},
  {"type":"object oriented","name":"PHP","id":8},
  {"type":"functional","name":"Scala","id":9},
  {"type":"functional","name":"Haskel","id":10}]
  """

  assert remove_whitespace(response) == remove_whitespace(expected_response)
end
  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end

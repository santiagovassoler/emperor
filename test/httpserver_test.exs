defmodule HttpServerTest do
  use ExUnit.Case

  alias Emperor.HttpServer
  alias Emperor.HttpClient

  test "accepts a request on a socket and sends back a response" do
    spawn(HttpServer, :start, [4001])

    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = HttpClient.send_request(request)

    assert response == """
    HTTP/1.1 200 OK\r
    content-type: text/html\r
    content-length: 20\r
    \r
    Bears, Lions, Tigers
    """
  end
end

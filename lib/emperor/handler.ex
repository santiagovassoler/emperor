defmodule Emperor.Handler do

alias  Emperor.Conv
alias  Emperor.BearController

import Emperor.FileHandler, only: [handle_file: 2]
import Emperor.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
import Emperor.Parser, only: [parse: 1]

@pages_path Path.expand("pages", File.cwd!)

  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{ method: "GET", path: "/" } = conv) do
    %{ conv | status: 200, resp_body: "Hello World" }
  end

  def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

  def route(%{method: "DELETE", path: "/bears/" <> _id} = conv) do
    BearController.delete(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/api/bears" } = conv) do
    Emperor.Api.BearController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears" } = conv) do
    BearController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears/" <> id } = conv) do
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    BearController.create(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/pages" } = conv) do
    BearController.pages(conv)
  end


  @pages Application.app_dir(:emperor, "priv/pages/")
  def route(%Conv{method: "GET", path: "/pages/" <> file} = conv) do
    ##@pages_path
    @pages
    |> Path.join(file <> ".html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here!"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    Content-Type: #{conv.resp_content_type}\r
    Content-Length: #{String.length(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end
end

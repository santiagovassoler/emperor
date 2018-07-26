defmodule Emperor.Handler do

alias  Emperor.Conv
alias  Emperor.LanguageController

import Emperor.FileHandler, only: [handle_file: 2]
import Emperor.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
import Emperor.Parser, only: [parse: 1]

  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  def route(%Conv{ method: "GET", path: "/helloworld" } = conv) do
    %{ conv | status: 200, resp_body: "Hello World" }
  end

  def route(%{method: "DELETE", path: "/languages/" <> _id} = conv) do
    LanguageController.delete(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/api/languages" } = conv) do
    Emperor.Api.LanguageController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/languages" } = conv) do
    LanguageController.index(conv)
  end

  def route(%Conv{ method: "GET", path: "/languages/" <> id } = conv) do
    params = Map.put(conv.params, "id", id)
    LanguageController.show(conv, params)
  end

  def route(%Conv{ method: "POST", path: "/languages"} = conv) do
    LanguageController.create(conv, conv.params)
  end

  def route(%Conv{ method: "GET", path: "/pages/" <> file} = conv) do
    Application.app_dir(:emperor, "priv/pages")
    |> Path.join("/"<> file <> ".html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "<h1>404</h1><br>Sorry #{path} not found!"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    content-type: #{conv.resp_content_type}\r
    content-length: #{String.length(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end
end

defmodule Emperor.View do
  require EEx
  #@templates_path Path.expand("../../templates", __DIR__)
  @templates_path Path.expand("templates", File.cwd!)

  def render(conv, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{ conv | status: 200, resp_body: content }
  end
end

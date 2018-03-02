defmodule Emperor.BearView do
  require EEx

  #@templates_path Path.expand("../../templates", __DIR__)
  @templates_path Path.expand("templates", File.cwd!)
  @pages_path Path.expand("pages", File.cwd!)

  EEx.function_from_file :def, :index, Path.join(@templates_path, "index.eex"), [:bears]
  EEx.function_from_file :def, :show,  Path.join(@templates_path, "show.eex"),  [:bear]

  EEx.function_from_file :def, :pages,  Path.join(@pages_path, "test.eex"), [:p]

  #def show(conv, %{"id" => id}) do
  #  bear = Wildthings.get_bear(id)
  #  %{ conv | status: 200, resp_body: BearView.show(bear) }
    #render(conv, "show.eex", bear: bear)
  #end
end

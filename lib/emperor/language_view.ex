defmodule Emperor.LanguageView do
  require EEx

  @templates_path Path.expand("templates", File.cwd!)

  EEx.function_from_file :def, :index, Path.join(@templates_path, "index.eex"), [:languages]
  EEx.function_from_file :def, :show,  Path.join(@templates_path, "show.eex"),  [:language]

end

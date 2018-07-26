defmodule Emperor.Api.LanguageController do

  def index(conv) do
    json =
      Emperor.Paradigm.list_languages()
      |> Poison.encode!

    %{ conv | status: 200, resp_content_type: "application/json", resp_body: json }
  end

end

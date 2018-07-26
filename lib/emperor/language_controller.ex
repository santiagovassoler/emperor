defmodule Emperor.LanguageController do

  alias Emperor.Paradigm
  alias Emperor.Language
  alias Emperor.LanguageView

  def index(conv) do
    languages =
      Paradigm.list_languages()
      |> Enum.sort(&Language.order_asc_by_name/2)
    %{ conv | status: 200, resp_body: LanguageView.index(languages)}
  end

  def show(conv, %{"id" => id}) do
    language = Paradigm.get_language(id)
    %{ conv | status: 200, resp_body: LanguageView.show(language) }
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{ conv | status: 201, resp_body: "Created #{name} language which is #{type}!" }
  end

  def delete(conv, _params) do
    %{ conv | status: 403, resp_body: "Deleting this item is forbidden!"}
  end

end

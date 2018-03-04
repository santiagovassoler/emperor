defmodule Emperor.BearController do

  alias Emperor.Wildthings
  alias Emperor.Bear
  alias Emperor.BearView

  def index(conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)
      #render(conv, "index.eex", bears: bears)
    %{ conv | status: 200, resp_body: BearView.index(bears)}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{ conv | status: 200, resp_body: BearView.show(bear) }
  end

def create(conv, %{"name" => name, "type" => type}) do
  %{conv.params | name: "fuck", type: "this"}
  IO.inspect conv.params
  %{ conv | status: 201, resp_body: "Created a #{type} bear named #{name}!" }
end

def create(conv, _) do
  %{conv.params | name: "fuck", type: "this"}
   %{ conv | status: 200, resp_body: "Created !" }
end

#  def create(conv, %{"name" => name, "type" => type}) do
#    %{ conv | status: 201, resp_body: "Created a #{type} bear named #{name}!" }
#  end

#  def create(conv, _) do
#   %{ conv | status: 200, resp_body: "Created nothing my man!" }
#  end

  def delete(conv, _params) do
    %{ conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

end

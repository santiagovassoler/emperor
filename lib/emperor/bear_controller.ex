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

@optional_params %{"name" => "default3", "type" => "default4"}

def create(conv, %{"name" => name, "type" => type} = params) do
  # `params` has precedence over `@optional_params`, that's why we're using it
  # as the second argument here.
  params = Map.merge(@optional_params, params)
  IO.inspect params
  %{ conv | status: 201, resp_body: "Created a #{type} bear named #{name}!" }
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

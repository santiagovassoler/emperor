defmodule Emperor.BearController do

  alias Emperor.Wildthings
  alias Emperor.Bear
  alias Emperor.BearView
  import Emperor.View, only: [render: 3]


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
    %{ conv | status: 201,
              resp_body: "Created a #{type} bear named #{name}!" }
  end

  def delete(conv, _params) do
    %{ conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  def pages(conv) do
    p =  "Hi from " <> Application.app_dir(:emperor, "priv/pages")
    IO.puts "bear controller wildcard" <> Path.wildcard(@pages<>"/*")
    %{ conv | status: 200, resp_body: BearView.pages(p)}
  end

end

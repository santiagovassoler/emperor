defmodule Emperor.Api.BearController do

  def index(conv) do
    json =
      Emperor.Wildthings.list_bears()
      |> Poison.encode!

    %{ conv | status: 200, resp_content_type: "application/json", resp_body: json }
  end

end

defmodule Emperor.Language do
  defstruct id: nil, name: "", type: ""

  def order_asc_by_name(b1, b2) do
    b1.name <= b2.name
  end

end

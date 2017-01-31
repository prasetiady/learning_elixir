defmodule Example do
  def default_params(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.default_params("a", "b")
Example.default_params("a", "b", "c")
Example.default_params("a", "b" , "c", "d")

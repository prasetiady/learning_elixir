defmodule MyList do
  def len([]), do: 0
  def len([ _head | tail ]), do: 1 + len(tail)
  def square([]), do: []
  def square([ head | tail ]), do: [ head*head | square(tail) ]
  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]
  def sum(list), do: _sum(list, 0)
  def reduce([], value, _) do
    value
  end
  def reduce([ head | tail ], value, func) do
    reduce(tail, func.(head, value), func)
  end
  # private methods
  defp _sum([], total), do: total
  defp _sum([ head | tail ], total), do: _sum(tail, total+head)
end

defmodule Bitmap do
  defstruct value: 0
  
  @doc """
  A simple accessor for the 2^bit value in an integer
    iex> b = %Bitmap{value: 5}
    %Bitmap{value: 5}
    iex> Bitmap.fetch_bit(b,2)
    1
    iex> Bitmap.fetch_bit(b,1)
    0
    iex> Bitmap.fetch_bit(b,0)
    1
  """
  def fetch_bit(%Bitmap{value: value}, bit) do
    use Bitwise
    (value >>> bit) &&& 1 
  end  
end

defimpl Enumerable, for: Bitmap do
  import :math, only: [log: 1]
  def count(%Bitmap{value: value}) do
    { :ok, trunc(log(abs(value))/log(2)) + 1 } 
  end
  
  def member?(value, bit_number) do
    { :ok, 0 <= bit_number && bit_number < Enum.count(value)} 
  end
  
  def reduce(bitmap, {:cont, acc}, func) do
    bit_count = Enum.count(bitmap)
    _reduce({bitmap, bit_count}, {:cont, acc}, func)
  end
  
  defp _reduce({bitmap, -1}, { :cont, acc }, _func), do: { :done, acc }
  
  defp _reduce({bitmap, bit_number}, { :cont, acc}, func ) do
    with bit = Bitmap.fetch_bit(bitmap, bit_number),
    do: _reduce({bitmap, bit_number-1}, func.(bit, acc), func)
  end
  
  defp _reduce({_bitmap, _bit_number}, { :halt, acc }, _func), do: { :halted, acc }
  
  defp _reduce({bitmap, bit_number}, { :suspend, acc }, func) do
    { :suspended, acc, &_reduce({bitmap, bit_number}, &1, func), func } 
  end
end

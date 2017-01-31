defmodule Attende do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attende = %Attende{}) do
    attende.paid && attende.over_18
  end

  def print_vip_bade(%Attende{name: name}) when name != "" do
    IO.puts "Very cheap badge for #{name}"
  end

  def print_vip_bade(%Attende{}) do
    raise "missing name for badge" 
  end
end

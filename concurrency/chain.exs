defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> 
        IO.puts "I #{inspect(self)} receive #{n} sending #{n+1} to #{inspect(next_pid)}"
        send next_pid, n + 1 
    end
  end
  
  def create_processes(n) do
    last = Enum.reduce 1..n, self,
              fn (_,send_to) ->
                spawn(Chain, :counter, [send_to])
              end
    
    send last, 0 # start the count by sending zero to the last process
    
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}" 
    end            
  end
  
  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n]) 
  end
end
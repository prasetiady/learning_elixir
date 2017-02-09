defmodule LearnGenserver do
  use Application
  
  def start(_type, _args) do
    {:ok, pid} = PackageReceiver.start_link
    
    ["Book", "Bat", "Broom", "Bananas"]
    |>  Enum.each (fn(package) -> 
          IO.puts "Delivering package: #{package}"
          PackageReceiver.leave_at_door(pid, package)
        end)
    
    IO.puts "All done"
    IO.puts "______________________________________"
    
    {:ok, pid}
  end
end

defmodule PackageReceiver do
  use GenServer
  
  def start_link do
    GenServer.start_link(__MODULE__, [])  
  end
  
  def leave_at_door(receiver_pid, package) do
    GenServer.cast(receiver_pid, {:asyn_package, package}) 
  end
  
  def handle_cast({:asyn_package, package}, state) do
    :timer.sleep(1000)
    IO.puts "Package received : #{package}"
    {:noreply, state} 
  end
end

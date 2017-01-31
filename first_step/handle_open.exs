handle_open = fn
  {:ok, file}  -> "First line: #{IO.read(file, :line)}"
  {_,   error} -> "Error: #{:file.format_error(error)}"
end
IO.puts handle_open.(File.open("handle_open.exs")) # call with a file that exist
IO.puts handle_open.(File.open("nonexist")) # and then with one that doesn't

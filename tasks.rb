require 'optparse'

OptionParser.new do |parser|

  file_name = 'tasks.dat'

  parser.on('-a', '--add TASK', 'Add an item to the list.') do |new_task|
    File.open(file_name, 'a') { |f| f.puts new_task }
  end

  parser.on('-l', '--list', 'Display the list.') do
    File.new(file_name, 'w') unless File.file?(file_name)

    File.readlines(file_name).each do |line|
      puts line unless line.empty?
    end
  end

  parser.on('-r', '--remove N', 'Remove the last N from the list.') do |n|
    survivors = File.readlines(file_name)[0..-n.to_i - 1]
    File.write(file_name, survivors.join)
  end

  parser.on('-c', '--clear', 'Clear the list.') do
    File.truncate(file_name, 0)
  end

  parser.on('-h', '--help', 'Show this help message') do
    puts parser
  end

end.parse!
require 'optparse'

options = {}
OptionParser.new do |opts|
    opts.banner = "Usage: example.rb [options]"
    
    opts.on("-r", "--require LIBRARY", "Require LIBRARY before executing") do |v|
        options[:lib] = v
    end
end.parse!

p options
p ARGV

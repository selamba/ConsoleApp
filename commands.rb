module Train
    Create = ->(input, input_words) {
        
    }
    Select = ->(input, input_words) {
        if input_words[2] == "count"
            command = "SELECT COUNT(*) FROM Trains"
            for str in input_words[3..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("Кол-во строк: #{row}")
            end
        end        
    }
    Update = ->(input, input_words) {
        
    }
    Delete = ->(input, input_words) {
        
    }
    Generate = ->(input, input_words) {
        
    }
end

module Station
    Create = ->(input, input_words) {
        
        }
    Select = ->(input, input_words) {
        if input_words[2] == "count"
            command = "SELECT COUNT(*) FROM Stations"
            for str in input_words[3..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("Кол-во строк: #{row}")
            end
        end    
    }
    Update = ->(input, input_words) {
        
        }
    Delete = ->(input, input_words) {
        
        }
    Generate = ->(input, input_words) {
        
        }
end

module Wagon
    Create = ->(input, input_words) {
        
        }
    Select = ->(input, input_words) {
        if input_words[2] == "count"
            command = "SELECT COUNT(*) FROM Wagons"
            for str in input_words[3..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("Кол-во строк: #{row}")
            end
        end
        }
    Update = ->(input, input_words) {
        
        }
    Delete = ->(input, input_words) {
        
        }
    Generate = ->(input, input_words) {
        
        }
end

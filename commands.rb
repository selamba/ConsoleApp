module Train
    Create = ->(input, input_words) {
        
    }
    Select = ->(input, input_words) {
        if input_words[2] == "count"
            command = "select count(*) from Trains"
	
            for str in input_words[3..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("Кол-во поездов: #{row}")
            end
        elsif input_words[2] == "where"
            command = "select * from Trains"
	
            for str in input_words[2..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("#{row}")
            end
		elsif input_words[2].start_with?("column")
			command = "select"
			where_index = 3
	
			for str in input_words[3..-1]
				if str == "where"
					break
				end
				where_index += 1
				command << " " << str
			end
			command << " from Trains"
			
			for str in input_words[where_index..-1]
				command << " " << str
			end
	
			App::DB.execute command do |row|
				App::SHELL.msg("#{row}")
			end
		end
    }
    Update = ->(input, input_words) {
		command = "update Trains set"
		where_index = 3
		
		for str in input_words[3..-1]
			if str == "where"
				break
			end
			where_index += 1
			command << " " << str
		end
	
		for str in input_words[where_index..-1]
			command << " " << str
		end
	
		App::DB.execute command
		App::SHELL.msg("Изменение данных прошло успешно.")
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
            command = "select count(*) from Stations"
	
            for str in input_words[3..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("Кол-во станций: #{row}")
            end
        elsif input_words[2] == "where"
            command = "select * from Stations"
	
            for str in input_words[2..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("#{row}")
            end
		elsif input_words[2].start_with?("column")
			command = "select"
			where_index = 3
	
			for str in input_words[3..-1]
				if str == "where"
					break
				end
				where_index += 1
				command << " " << str
			end
			command << " from Stations"
			
			for str in input_words[where_index..-1]
				command << " " << str
			end
	
			App::DB.execute command do |row|
				App::SHELL.msg("#{row}")
			end
		end
    }
    Update = ->(input, input_words) {
		command = "update Stations set"
		where_index = 3
		
		for str in input_words[3..-1]
			if str == "where"
				break
			end
			where_index += 1
			command << " " << str
		end
	
		for str in input_words[where_index..-1]
			command << " " << str
		end
	
		App::DB.execute command
		App::SHELL.msg("Изменение данных прошло успешно.")
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
            command = "select count(*) from Wagons"
	
            for str in input_words[3..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("Кол-во вагонов: #{row}")
            end
        elsif input_words[2] == "where"
            command = "select * from Wagons"
	
            for str in input_words[2..-1]
                command << " " << str
            end
    
            App::DB.execute command do |row|
                App::SHELL.msg("#{row}")
            end
		elsif input_words[2].start_with?("column")
			command = "select"
			where_index = 3
	
			for str in input_words[3..-1]
				if str == "where"
					break
				end
				where_index += 1
				command << " " << str
			end
			command << " from Wagons"
			
			for str in input_words[where_index..-1]
				command << " " << str
			end
	
			App::DB.execute command do |row|
				App::SHELL.msg("#{row}")
			end
		end
    }
    Update = ->(input, input_words) {
		command = "update Wagons set"
		where_index = 3
		
		for str in input_words[3..-1]
			if str == "where"
				break
			end
			where_index += 1
			command << " " << str
		end
	
		for str in input_words[where_index..-1]
			command << " " << str
		end
	
		App::DB.execute command
		App::SHELL.msg("Изменение данных прошло успешно.")
        }
    Delete = ->(input, input_words) {
        
        }
    Generate = ->(input, input_words) {
        
        }
end

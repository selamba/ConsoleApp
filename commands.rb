module Commands
	def self.select(input_words)
		table = entity(input_words[0])
		
		if input_words[2] == "count"
			command = "select count(*) from #{table}"
			
			for str in input_words[3..-1]
				command << " " << str
			end
			
			App::DB.execute command do |row|
				App::SHELL.msg("Кол-во сущностей: #{row}")
			end
		elsif input_words[2] == "where"
			command = "select * from #{table}"
			
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
			command << " from #{table}"
			
			for str in input_words[where_index..-1]
				command << " " << str
			end
			
			App::DB.execute command do |row|
				App::SHELL.msg("#{row}")
			end
		end
	end
	
	def self.update(input_words)
		table = entity(input_words[0])
		command = "update #{table} set"
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
	end
	
	def self.delete(input_words)
		table = entity(input_words[0])
		command = "delete from #{table}"
		
		for str in input_words[2..-1]
			command << " " << str
		end
		
		App::DB.execute command
		App::SHELL.msg("Удаление данных прошло успешно.")
	end
	
	private
	
	def self.entity(str)
		return (str.capitalize << "s")
	end
end

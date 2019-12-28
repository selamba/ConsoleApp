module Commands
	HELP_MESSAGES = {
		:help => "help help message",
		:select => "select help message",
		:update => "update help message",
		:delete => "delete help message"
		}
	
	def self.help
		for method in Commands.singleton_methods(false)
			App::SHELL.msg("#{method}: #{HELP_MESSAGES[method]}")
		end
	end
	
	def self.menu
		number = 1
		index = Hash.new
		
		# Вывод списка методов
		for ent in Shell::Entities
			for method in Commands.singleton_methods(false)
				if [:menu, :help].include?(method)
					next
				end
				
				puts("#{number}. #{ent} #{method}")
				index[number] = "#{ent} #{method}"
				number += 1
			end
		end
		
		# Выбор команды из списка
		number = 0
		until number > 0 do
			App::SHELL.msg("Выберите команду (номер команды): ", false)
			number = gets.chomp.to_i
		end
		command = index[number]
		
		# Дописывание команды
		App::SHELL.msg("Допишите команду:")
		print("#{command} ")
		command << " " << gets.chomp
		input_words = command.split(" ")
		Commands.send(input_words[1], input_words)
	end
	
	def self.select(input_words)
		# Целевая таблица
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
	
	def self.generate(input_words)
		table = entity(input_words[0])
		amount = input_words[2]
		columns, values = [], []
		
		for str in input_words[3..-1]
			pair = str.split("=")
			columns << pair[0]
			values << pair[1]
		end
		
		amount.to_i.times do
			App::DB.execute "insert into #{table} (#{columns.join(", ")})
			values (#{values.join(", ")})"
		end
		App::SHELL.msg("Генерация сущностей прошла успешно.")
	end
	
	# Преобразование сущности в название таблицы
	private_class_method def self.entity(str)
		return (str.capitalize << "s")
	end
end

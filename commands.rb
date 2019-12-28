module Commands
	HELP_MESSAGES = {
		:help => "Выводит этот список.\n",
		:select => "Выводит строки в зависимости от аргументов: * select [columns/count/ ] where ...\n"\
					"\tПосле 'where' пишутся колонки, по которым происходит выборка.\n"\
					"\tПример: train select columns id, forming_station where id=1, idx=123456 order by id asc\n",
		:update => "Обновляет строки в зависимости от аргументов: * update ... where ...\n"\
					"\tПеред 'where' колонки, по которым выбираются строки для изменения, а после - колонки, которые надо поменять.\n"\
					"\tПример: station update code_esr6='123123-456-789789' where id=55\n",
		:delete => "Удаляет строки в зависимости от аргументов: * delete where ...\n"\
					"\tПосле 'where' указать, какие строки удалить.\n"\
					"\tПример: wagon delete where npp=100, cargo_name='Coal'\n",
		:generate => "Генерирует строки с указанными значениями колонок: * generate [кол-во] ...\n"\
					"\tПосле 'generate' кол-во строк для генерации, после кол-ва значения колонок этих строк.\n"\
					"\tКолонки, для которых не было указано значение, не будут иметь значения (nil).\n"\
					"\tПример: train generate 100 destination_station='Станция такая-то', number = 123456\n",
		:menu => "Выводит список доступных команд.\n",
		:create => "Создаёт строку с указанными значениями колонок: * create ...\n"\
					"\tПосле 'create' значения колонок этой строки.\n"\
					"\tПример: train create idx=55, number = 123456\n",
		}
	
	def self.help
		App::SHELL.msg("* (звёздочка) - сущность, на которую направлена команда.")
		App::SHELL.msg("... (троеточие) - аргументы команды.")
		puts()
		
		for method in Commands.singleton_methods(false)
			if method == :help or method == :menu
				next
			end
			App::SHELL.msg("#{method}: #{HELP_MESSAGES[method]}")
		end
		App::SHELL.msg("#{"menu"}: #{HELP_MESSAGES[:menu]}")
		App::SHELL.msg("#{"help"}: #{HELP_MESSAGES[:help]}")
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
	
	def self.create(input_words)
		table = entity(input_words[0])
		args = input_words[2..-1]
		columns, values = [], []
		
		# Обработка аргументов
		for arg in args
			arg.delete!(",")
			tmp = arg.split("=")
			columns << tmp[0]
			values << tmp[1]
		end
		command = "insert into #{table} (#{columns.join(", ")}) values (#{values.join(", ")})"
		
		App::DB.execute command
		App::SHELL.msg("Создание строки прошло успешно.")
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
		where_index = 2
		
		for str in input_words[2..-1]
			if str == "where"
				break
			end
			where_index += 1
			command << " " << str
		end
		
		for str in input_words[where_index..-1]
			if str.end_with?(",")
				str.delete!(",")
				str << " and"
			end
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
		amount = input_words[2].to_i
		columns, values = [], []
		
		for str in input_words[3..-1]
			pair = str.split("=")
			columns << pair[0]
			values << pair[1]
		end
		
		# Если число введено неверно
		if amount < 1
			App::SHELL.msg("Неверно задано число строк для генерации.")
			return
		end
		
		amount.times do
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

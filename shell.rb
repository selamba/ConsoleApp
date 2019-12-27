require_relative "commands"



class Shell
    Clear_screen = "clear"  # Команда очистки экрана
    Success_msg = "Операция успешно выполнена."
    @@command_history = []  # История введённых команд
	Entities = [	# Список корректных сущностей
		"train",
		"station",
		"wagon"
	]
    Entity_commands = [     # Список корректных команд
        "create",
        "select",
        "update",
        "delete",
        "generate"
    ]
    
            
    # Главный цикл
    def start
        # Очистка экрана
        system(Clear_screen)
        
        # Сам цикл
        loop do
            print(">> ")
            input = gets.chomp
            
            # Поддержание истории введённых команд
            # TODO: взаимодействие с историей
            @@command_history.push(input)
            if @@command_history.length > 32
                @@command_history.delete_at(0)
            end

            # Обработка ввода
			# SQL injection, на всякий случай
			if input.include?(";")
				self.msg("Не используйте точки с запятой.")
				next
			end
			
            if input == "exit"
                system(Clear_screen)
                return
			elsif input == "help"
				Commands::help
				next
			end
			input_words = input.split(" ")
			
			# Проверка сущности на корректность
			if !Entities.include?(input_words[0])
				self.msg("Неверная сущность: #{input_words[0]}")
				next
			end
                        
            # Проверка команды на корректность
            target_command = input_words[1]
            if !Entity_commands.include?(target_command)
                self.msg("Неверная команда: #{target_command}")
                next
            end
            
            # Выполнение запроса
			Commands.send(target_command, input_words)
        end
    end
    
    # Вывод msg на экран
    def msg(msg, newline = true)
        print(msg)
        puts() if newline
    end
end

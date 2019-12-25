require_relative "commands"



class Shell
    Clear_screen = "clear"  # Команда очистки экрана
    Success_msg = "Операция успешно выполнена."
    @@command_history = []  # История введённых команд
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
            if input == "exit"
                system(Clear_screen)
                return
            end
			input_words = input.split(" ")
                        
            # Обработка целевой команды
            target_command = input_words[1]
            if !Entity_commands.include?(target_command)
                self.msg("Неверная команда: #{target_command}")
                next
            end
            
            # Самое интересное
			Commands.send(target_command, input_words)
        end
    end
    
    # Вывод msg на экран
    def msg(msg, newline = true)
        print(msg)
        puts() if newline
    end
end

require_relative "commands"



class Shell
    #Ruby_command = "ruby"   # Команда для вызова интерпретатора
    Clear_screen = "clear"  # Команда очистки экрана
    Success_msg = "Операция успешно выполнена."
    @@command_history = []  # История введённых команд
    
            
    # Главный цикл
    def start
        # Очистка экрана
        system(Clear_screen)
        
        # Сам цикл
        loop do
            print(">> ")
            input = gets.chomp
            
            # Поддержание истории введённых команд
            @@command_history.push(input)
            if @@command_history.length > 32
                @@command_history.delete_at(0)
            end
            

            # Обработка ввода
            case input
            when "exit"
                # Очистка экрана
                system(Clear_screen)
                break
            when "train create"
                Train::create(4, 1337, 50, "Павелецкий", 3, 3, 3)
            else
                self.msg("Неизвестная команда: #{input}")
                self.msg("Напишите \"help\" для помощи.")
            end
        end
    end
    
    # Вывод msg на экран
    def msg(msg, newline = true)
        print(msg)
        puts() if newline
    end
end

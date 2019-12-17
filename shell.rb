require "sqlite3"

class Shell
    # Перменная для введенных команд, чтобы она не создавалась
    # снова и снова внутри главного цикла
    @@input = ""
    
    # Список команд
    @@commands = [
        "help",
        "exit"
    ]
    
    # Выводится при команде help
    @@help_strings = Hash[
        "help" => "Выводит эту информацию.",
        "exit" => "Осуществялет выход из программы."
    ]
    
    def self.start
        loop do
             print (">> ")
             input = gets.chomp
             
             case input
             when "help"
                 for com in @@commands
                     puts("#{com}: #{@@help_strings[com]}")
                 end
             when "exit"
                 system("clear")
                 break
             else
                 puts("Неизвестная команда: #{input}")
                 puts("Введите \"help\" для информации о пользовании.")
             end
        end
    end
end

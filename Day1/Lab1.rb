class Inventory 

    def initialize()
        @books=[]
    end
    
    def add_book(title, author, isbn)
        if (title == "" || title.class != String || author == "" || author.class != String ||isbn == "" || isbn.class != String)
            puts "Invalid input"
            return
        end 
        @books.each do |book|
            if(book[:ISBN] == isbn)
                book[:title] = title
                book[:author] = author
                book[:count] += 1
                write_to_file 'inventory.txt', 'w'
            return
            end
        end
        book = {title: title, author: author, ISBN: isbn, count: 1}
        @books.push({title: title, author: author, ISBN: isbn, count: 1})
        write_to_file 'inventory.txt', 'a', book
    end

    def remove_book(isbn)
        book_length = @books.length
       x = @books.delete_if {|book| book[:ISBN] == isbn}
       if(x.length == book_length)
        puts "Book not found"
        return
       end    
       write_to_file 'inventory.txt', 'w'
    end

    def list_books
        if(@books.length == 0)
            puts "No books in inventory"
            return
        end
        @books.each do |book|
        puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}, Count: #{book[:count]}"
        end
    end

    def sort_books
        @books = @books.sort_by { |book| book[:ISBN]}
        write_to_file 'inventory.txt', 'w'
    end

    def search_book(search_value)
        flag = 0
        @books.each do |book|
            if book[:title] == search_value || book[:author] == search_value || book[:ISBN] == search_value
                puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}, Count: #{book[:count]}"
                flag = 1
            end
        end
        if flag == 0
            puts "Book not found"
        end
    end

    private
    def write_to_file file_name, mode, book = {}
        if mode == 'w' 
            File.open(file_name, 'w') do |file|
                @books.each do |book|
                file.puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}, Count: #{book[:count]}"
                end
            end
        elsif mode == 'a'
            File.open(file_name, 'a') do |file|
                file.puts "Title: #{book[:title]}, Author: #{book[:author]}, ISBN: #{book[:ISBN]}, Count: #{book[:count]}"
            end
        end
    end
end    

inventory = Inventory.new
flag = 1
while flag == 1
    puts "\nSelect Option:\n 1 to list books,\n 2 to add new book,\n 3 to remove book by ISBN,\n 4 to sort books,\n 5 to search for a book,\n 6 to exit\n"
    puts "Enter your choice:"
    choice = gets.chomp.to_i

    case choice

    when 1
        inventory.list_books

    when 2
        puts "Enter title:"
        title = gets.chomp
        puts "Enter author:"
        author = gets.chomp
        puts "Enter ISBN:"
        isbn = gets.chomp
        inventory.add_book title, author, isbn

    when 3
        puts "Enter ISBN:"
        isbn = gets.chomp
        inventory.remove_book isbn

    when 4
        inventory.sort_books

    when 5
        puts "Enter title, author or ISBN:"
        search_value = gets.chomp
        inventory.search_book search_value
        
    when 6
        puts "Exiting..."
        flag = 0

    else
        puts "Invalid choice"
    end
end
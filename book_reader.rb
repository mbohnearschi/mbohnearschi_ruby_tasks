class BookParser
  attr_accessor :pages, :name, :author

  def initialize(file_name)
    words = File.read(file_name).split(/( )/)
    @pages = parse_words(words)
  rescue
    @pages = []
  end

  def parse_words(words)
    # words = words(lines)
    temp_pages = []

    temp_page = ''
    words.each_with_index do |word, index|
      if temp_page.length + word.length > 800
        temp_pages.push temp_page.dup
        temp_page = ''
      end
      temp_page += word
      next unless index == words.size - 1
      temp_pages.push temp_page unless temp_page.empty?
    end
    temp_pages
  end

  def total_pages
    @pages.length
  end

  def print(page)
    puts @pages[page - 1]
    puts "\n\nPage #{page} from #{total_pages}\n\n"
  end
end

class BookReader
  attr_accessor :help, :book, :current_page, :bookmarked

  def initialize(file_name)
    @help = %(
    Here are the available actions:
    help      - This message
    name      - Change the name of the book
    author    - Change the Author of the book
    page      - Go to certain page
    total     - Get total pages
    current   - Get current page
    next      - Get next page
    previous  - Get previous page
    first     - Get first page
    last      - Get last page
    skip      - Skip N pages
    bookmark  - Bookmark current page
    bookmarks - Get bookmarked page numbers
  )
    @book = BookParser.new(file_name)
    @current_page = 1
    @bookmarked = []
  end

  def start
    parsed_successfully = @book.pages.any?
    puts "Book parsed successfully: #{parsed_successfully}\n\n"

    if parsed_successfully
      print_help
      print_choice

      loop do
        input = gets
        handle_input(input.strip.to_s.downcase)
      end
    end
  end

  def handle_input(input)
    case input
    when 'help'
      print_help
    when 'name'
      handle_name
    when 'author'
      handle_author
    when 'total'
      handle_total
    when 'page'
      handle_page
    when 'current'
      @book.print @current_page
    when 'next'
      handle_next
    when 'previous'
      handle_previous
    when 'first'
      @current_page = 1
      @book.print @current_page
    when 'last'
      @current_page = @book.total_pages
      @book.print @current_page
    when 'bookmark'
      if @bookmarked.include?(@current_page)
        puts "Page #{@current_page} removed from bookmarks."
        @bookmarked.delete(@current_page)
      else
        puts "Page #{@current_page} added to bookmarks."
        @bookmarked << @current_page
      end
    when 'bookmarks'
      puts "Here are the bookmarked pages: #{@bookmarked}"
    else
      handle_unknown
    end
    print_choice
  end

  def handle_unknown
    puts 'Unknown command'
    print_help
  end

  def handle_name
    puts "Current book name: #{@book.name}"
    print 'Please enter new book name: '
    new_name = gets.to_s
    @book.name = new_name
    puts "Book name changed to: #{new_name}\n"
  end

  def handle_author
    puts "Current book author: #{@book.author}"
    print 'Please enter new book author name: '
    new_name = gets.to_s
    @book.author = new_name
    puts "Book author changed to: #{new_name}\n"
  end

  def handle_total
    puts "Total number of pages is: #{@book.total_pages}\n\n"
  end

  def handle_page
    handle_total

    print 'Please select the desired page: '

    desired_page = gets.to_i

    if desired_page > @book.total_pages || desired_page < 1
      puts "The desired page is out of bounds\n\n"
    else
      @book.print desired_page
      @current_page = desired_page
    end
  end

  def handle_next
    if @current_page < @book.total_pages
      @current_page += 1
      @book.print @current_page
    else
      puts "You've reached the limits!\n\n"
    end
  end

  def handle_previous
    if @current_page > 1
      @current_page -= 1
      @book.print @current_page
    else
      puts "You've reached the limits!\n\n"
    end
  end

  def print_help
    puts @help
  end

  def print_choice
    print 'Please choose an action: '
  end

end

book_reader = BookReader.new('book_source.txt')
book_reader.start
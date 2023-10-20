require 'date'

# item class
class Item
  attr_accessor :label, :publish_date, :archived
  attr_reader :id

  @count = 1
  def initialize(publish_date, archived: false)
    @id = self.class.next_id
    @publish_date = DateTime.strptime(publish_date, '%Y-%m-%d')
    @archived = archived
  end

  def genre=(genre)
    @genre = genre
    @genre.items.push(self) unless @genre.items.include?(self)
  end

  def author=(author)
    @author = author
    @author.items.push(self) unless @author.items.include?(self)
  end

  def add_label(label)
    @label = label
    label.items << self unless label.items.include?(self)
  end

  def self.next_id
    @count ||= 1
    @count += 1
    @count - 1
  end

  def can_be_archived?
    (Time.now.year - @publish_date.year) > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end

class Item
  attr_accessor :genre, :author, :source, :label, :publish_date
  attr_reader :id, :archived

  def initialize(id, genre, author, source, label, publish_date, archived = false)
    @id = id
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = archived
  end

  def can_be_archived?
    (Time.now - @publish_date) > 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    end
  end
end
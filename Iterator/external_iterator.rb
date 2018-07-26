class ExternalIterator
  def initialize(collection)
    @collection = collection
    @index = 0
  end

  def has_next?
    @index < @collection.length
  end

  def item
    @collection[@index]
  end

  def next_item
    value = item
    @index += 1
    value
  end
end

array = %w[ apple banana cherry dragonfruit ]

i = ExternalIterator.new(array)

while i.has_next? do
  p i.next_item
end

string = "abcd"

i = ExternalIterator.new(string)

while i.has_next? do
  p i.next_item
end

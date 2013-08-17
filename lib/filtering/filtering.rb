module Filtering
  def filter(&criteria)
    results = []
    each do |item|
      results << item if yield item
    end
    results
  end
end

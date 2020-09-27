# Class Documents is the wrapper for document
class Documents
  # Setup reader for docs so we can see the info at least if needed
  attr_reader :docs
  # But make protected because I don't want others stuffing in without going through the process
  protected :docs
  # Initialize object
  def initialize
    @docs = []
  end
  # Add an item to the array (add processing here if needed)
  def << document
    # Convert the DATE field to an actual DATE!
    document.date = DateTime.parse document.date rescue nil
    # Convert all the updates to an actuall DATE!
    updates = []
    document.updates.split('|').each do |date|
      next if date.empty?
      updates << DateTime.parse(date) rescue nil
    end
    document.updates = updates
    @docs << document
  end

  # Return docs by date :ASC or :DESC... or nil
  def order_by by, dir = :DESC
    return nil unless [:date].include? by.to_sym
    eval("return @docs.sort_by(&:#{by.to_s}) if dir == :ASC")
    eval("return @docs.sort_by(&:#{by.to_s}).reverse if dir == :DESC")
    nil
  end

end

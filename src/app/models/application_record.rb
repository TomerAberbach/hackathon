class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ##
  # Defines a setter which nicely formats the +String+ argument for before setting
  # for each of the given +attributes+.
  # Options:
  # +options[:strip]+ - Removes whitespace from the ends of the +String+ (default: +true+).
  # +options[:single_spaces]+ - Replaces sequences of consecutive spaces in the +String+ with single spaces (default: +true+).
  def self.text_writer(*attributes, **options)
    # Default options
    options[:strip] = true if options[:strip].nil?
    options[:single_spaces] = true if options[:single_spaces].nil?

    # This multi-statement lambda construction only executes the conditionals once
    operations = []
    operations.push(lambda(&:strip)) if options[:strip]
    operations.push(lambda { |s| s.gsub(/\s+/, ' ') }) if options[:single_spaces]

    # Function applying selected operations
    transform = lambda { |value| operations.reduce(value) { |acc, operation| operation.call(acc) } }

    # Defines the setter method for each attribute
    attributes.each do |attribute|
      define_method("#{attribute}=") do |value|
        # Super method sets attribute normally
        super(
          if value.nil?
            value
          elsif value.kind_of?(Array)
            value.lazy.select { |element| !element.nil? }.map { |element| transform.call(element) }.to_a
          else
            transform.call(value)
          end
        )
      end
    end
  end
end

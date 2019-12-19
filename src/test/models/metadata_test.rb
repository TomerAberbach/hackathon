require 'test_helper'

class MetadataTest < ActiveSupport::TestCase
  test "allows only one metadata instance" do
    assert_raise ActiveRecord::RecordInvalid do
      Metadata.create!(
        name: 'HackTCNJ',
        description: 'An awesome hackathon!',
        keywords: %w[hack tcnj awesome code],
        email: 'acm@tcnj.edu',
        capacity: 200
      )
    end
  end

  test "text writer sanitizes fields" do
    metadata = Metadata.first

    metadata.name = '   HackTCNJ   '
    assert_equal('HackTCNJ', metadata.name)

    metadata.description = 'An  awesome    hackathon!'
    assert_equal('An awesome hackathon!', metadata.description)

    metadata.keywords = ['hack   ', '  tcnj ', 'awesome', 'code']
    assert_equal(%w[hack tcnj awesome code], metadata.keywords)
  end
end

if Rails.env.development?
  ActiveRecord::Base.transaction do
    Metadata.create!(
      name: 'HackTCNJ',
      description: 'A swell hackathon.',
      keywords: %w[hackathon tcnj],
      email: 'acm@tcnj.edu',
      capacity: 200
    )
    MailingList.create!(emails: [])
  end
end
Admin.invite!(email: ENV['ADMIN_EMAIL'])

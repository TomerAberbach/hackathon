ActiveRecord::Base.transaction do
  Metadata.create!(
    name: 'Placeholder Name',
    description: 'Placeholder Description.',
    keywords: %w[placeholder keywords],
    email: "placeholder@#{ENV['DOMAIN']}",
    capacity: 200
  )
  MailingList.create!(emails: [])
  Admin.invite!(email: ENV['ADMIN_EMAIL'])
end

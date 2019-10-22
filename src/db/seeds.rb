if Rails.env.development?
  Metadata.create!(
    name: 'HackTCNJ',
    description: 'A swell hackathon.',
    tags: %w[hackathon tcnj],
    host: 'TCNJ',
    email: 'acm@tcnj.edu',
    capacity: 200
  )
end
User.invite!(email: ENV['EMAIL'])

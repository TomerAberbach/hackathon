# Hackathon

> A hackathon web application with a comprehensive administrative backend, email infrastructure, attendee registration, and optional MLH integration.

## Deploying

### Automatic

Click on the following button to deploy the web application to Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

### Manual

**TODO**

## Environment Variables

### Local and Production

For sending emails (sign up at [SendGrid](https://sendgrid.com)):
* `SENDGRID_USERNAME`
* `SENDGRID_PASSWORD`

Other:
* `ADMIN_EMAIL`: An email address to send an admin account invite to. The recipient will become the super admin of the website.
* `DOMAIN`: The domain name of the website (e.g. hacktcnj.com).

### Only Production

* `CLOUDINARY_URL` for non-ephemeral file storage on Cloudinary.
* `PORT`

## Development

**TODO**

## Contributing

See [CONTRIBUTING.md](https://github.com/TomerAberbach/hackathon/blob/master/.github/CONTRIBUTING.md) for contributing guidelines.

## License

Copyright © 2019 [Tomer Aberbach](https://github.com/TomerAberbach) and [Thomas Orth](https://github.com/TomOrth)
Released under the [MIT license](https://github.com/TomerAberbach/hackathon/blob/master/LICENSE).

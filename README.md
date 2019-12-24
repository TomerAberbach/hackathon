# Hackathon

> A hackathon web application with a comprehensive administrative backend, email infrastructure, attendee registration, and optional MLH integration.

## Deployment

### Platform

#### Heroku

##### Automatic

Click on the following button to deploy the web application to Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

##### Manual

Perform the following steps:
1. Sign up for an account at [Heroku](https://heroku.com) and [install the Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install) if you have not already done so.
2. Clone the repository and change your current working directory to the newly created `hackathon` directory:
   * SSH (use if you have [configured an SSH key with GitHub](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)):
     ```sh
     $ git clone git@github.com:TomerAberbach/hackathon.git
     $ cd hackathon
     ```
   * HTTPS:
     ```sh
     $ git clone https://github.com/TomerAberbach/hackathon.git
     $ cd hackathon
     ```
3. Log in to Heroku through the Heroku CLI:
   ```sh
   $ heroku login
   ```
4. Create a Heroku application:
   * SSH (use if you have [configured an SSH key with Heroku](https://devcenter.heroku.com/articles/keys#adding-keys-to-heroku)):
     ```sh
     $ heroku create --ssh-git
     ```
   * HTTPS:
     ```sh
     $ heroku create --ssh-git
     ```
5. Configure the application's [buildpacks](https://devcenter.heroku.com/articles/buildpacks) (Active Storage preview and Ruby):
   ```sh
   $ heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
   $ heroku buildpacks:add -i 2 heroku/ruby
   ```
6. Configure the application's [Heroku addons](https://devcenter.heroku.com/articles/add-ons) (SendGrid and Cloudinary):
   ```sh
   $ heroku addons:create sendgrid
   $ heroku addons:create cloudinary
   ```
   The previous commands set the `SENDGRID_USERNAME`, `SENDGRID_PASSWORD`, and `CLOUDINARY_URL` environment variables for you on Heroku.
7. Set the application's `ADMIN_EMAIL` and `DOMAIN`. Refer to the **Environment Variables** section for a description of each environment variable:
   ```sh
   $ heroku config:set ADMIN_EMAIL=youradmin@email.com
   $ heroku config:set DOMAIN=yourdomain.com
   ```
   You may choose to set the `DOMAIN` environment variable to Heroku's randomly generated hostname initially, and then update it upon securing and [configuring a custom domain name with Heroku](https://devcenter.heroku.com/articles/custom-domains).
8. Run the following command and verify that each environment variable in the **Environment Variables** section is included in the output:
   ```sh
   $ heroku config
   ```
9. Determine the current Git branch using by running `git branch` and then deploy the application to Heroku:
   ```sh
   $ git push heroku current_branch_name:master
   ```
10. Migrate and seed the application's database:
    ```sh
    $ heroku run rails db:migrate db:seed
    ```
    At this point the email address set in the `ADMIN_EMAIL` environment variable should have received an invitation email, but the link in the email will not work until the next step is completed.
11. Scale the application to use a single [dyno](https://devcenter.heroku.com/articles/dynos), a lightweight Linux container:
    ```sh
    $ heroku ps:scale web=1
    ```

You can now view the application home page by running `heroku open` or navigating to its URL in a web browser. Additionally, the link in the invitation email sent to the email address set in the `ADMIN_EMAIL` environment variable should now be used to create the super admin account. Lastly, the application dashboard is accessible at the `/dashboard` path. For example, if your `DOMAIN` environment variable is set to `hacktcnj.com`, then the application dashboard can be found at `hacktcnj.com/dashboard`.

###### Appendix

In general, you can run any command on your Heroku dyno using `heroku run <your-command>`. To start a remote interactive shell session on your heroku dyno run the following command (press <kbd>Ctrl+C</kdb> to stop viewing the logs):
```sh
$ heroku run bash
```

If you need to clear the application's database run the following command, which is **irreversible**:
```sh
$ heroku run DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:schema:load
```
You will probably want to reseed the database afterwards:
```sh
$ heroku run rails db:seed
```

If view your application's logs in realtime run the following command (press <kbd>Ctrl+C</kdb> to stop viewing the logs):
```sh
$ heroku logs --tail
```

### Environment Variables

Sign up for an account at [SendGrid](https://sendgrid.com) and set the `SENDGRID_USERNAME` and `SENDGRID_PASSWORD` environment variables. The website requires SendGrid to send emails.

Set the `ADMIN_EMAIL` environment variable to an email address. The email address will receive a super admin account invitation email when the website's database is initially populated. The super admin can then invite additional admins if necessary. 

Set the `DOMAIN` environment variable to the domain name, without a protocol prefix or path suffix, that targets the website. For example, `hacktcnj.com` is a valid value.

In the development and test environments, Active Storage, which is responsible for storing images and documents, is configured to use the local file system. However, in the production environment, Active Storage is configured to use Cloudinary, a cloud storage provider, because many website hosting providers provide an ephemeral file system, which cannot persist data. Sign up for an account at [Cloudinary](https://cloudinary.com) set the `CLOUDINARY_URL` environment variable in the production environment.

## Development

1. Install [Ruby and Rails](https://gorails.com/setup) and [PostgreSQL](http://postgresguide.com/setup/install.html).
2. Clone the repository and change your current working directory to the newly created `hackathon` directory:
   * SSH (use if you have [configured an SSH key with GitHub](https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)):
     ```sh
     $ git clone git@github.com:TomerAberbach/hackathon.git
     $ cd hackathon
     ```
   * HTTPS:
     ```sh
     $ git clone https://github.com/TomerAberbach/hackathon.git
     $ cd hackathon
     ```
3. Set the environment variables listed in the **Environment Variables** section by creating an `application.yml` file in the `config` directory and setting the appropriate environment variable values like so:
   ```yaml
   SENDGRID_USERNAME: "your SendGrid username"
   SENDGRID_Password: "your SendGrid password"
   ADMIN_EMAIL: "your email address"
   DOMAIN: "localhost:3000"
   ```
   DO **NOT** CHECK THIS FILE INTO VERSION CONTROL.
4. Install the project dependencies:
   ```sh
   $ bundle install
   ```
   If you encounter errors, try restarting PostgreSQL and installing additional updates.
5. Set up the database:
   ```sh
   $ rails db:setup
   ```
6. Run the application (visit at [localhost:3000]):
   ```sh
   $ rails server
   ```
   Modify code and refresh web pages to see the difference.

## Resources

* [Getting Started with Rails](https://guides.rubyonrails.org/getting_started.html)

### Models
* [What is ActiveRecord?](https://guides.rubyonrails.org/active_record_basics.html)
* [Model Querying](https://guides.rubyonrails.org/active_record_querying.html)
* [Model Validation](https://guides.rubyonrails.org/active_record_validations.html)
* [Model Callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)
* [Migrations](https://guides.rubyonrails.org/active_record_migrations.html)
* [Model Associations](https://guides.rubyonrails.org/association_basics.html)

### Controllers
* [What is a Controller?](https://guides.rubyonrails.org/action_controller_overview.html)
* [Routing](https://guides.rubyonrails.org/routing.html)

### Views
* [Layouts and Rendering](https://guides.rubyonrails.org/layouts_and_rendering.html)
* [Forms](https://guides.rubyonrails.org/form_helpers.html)

### Other
* [File Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html)
* [Sending Emails](https://guides.rubyonrails.org/action_mailer_basics.html)

## Contributing

See [CONTRIBUTING.md](https://github.com/TomerAberbach/hackathon/blob/master/.github/CONTRIBUTING.md) for contributing guidelines.

## License

Copyright © 2019 [Tomer Aberbach](https://github.com/TomerAberbach) and [Thomas Orth](https://github.com/TomOrth)
Released under the [MIT license](https://github.com/TomerAberbach/hackathon/blob/master/LICENSE).

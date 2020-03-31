host = 'sharetask.work'
Rails.application.routes.default_url_options[:host] = host
if Rails.env.test?
  ActionMailer::Base.smtp_settings = {
    address: 'localhost',
    port:    587,
  }
else
  ActionMailer::Base.smtp_settings = {
    user_name:             ENV['SMTP_USER'],
    password:              ENV['SMTP_PASS'],
    domain:                ENV['SMTP_DOMAIN'],
    address:               'smtp.sendgrid.net',
    port:                  587,
    authentication:        :plain,
    enable_starttls_auto:  true
  }
end

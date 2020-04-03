host = 'sharetask.work'
Rails.application.routes.default_url_options[:host] = host
ActionMailer::Base.smtp_settings = if Rails.env.test?
                                     {
                                       address: 'localhost',
                                       port: 587
                                     }
                                   else
                                     {
                                       user_name: ENV['SMTP_USER'],
                                       password: ENV['SMTP_PASS'],
                                       domain: ENV['SMTP_DOMAIN'],
                                       address: 'smtp.sendgrid.net',
                                       port: 587,
                                       authentication: :plain,
                                       enable_starttls_auto: true
                                     }
                                   end

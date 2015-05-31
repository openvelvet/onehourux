ActionMailer::Base.smtp_settings = {
	address: 'smtp.mandrillapp.com',
  portal: 587,
  enable_starttls_auto: true,
  user_name: "app36695907@heroku.com",
  password: "sFAy3w0KVE8bs7blkzDdlQ",
  authentication: "login"
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'
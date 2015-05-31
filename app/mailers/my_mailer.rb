class MyMailer < ApplicationMailer

	def mandrill_client
		@mandrill_client ||= Mandrill::API.new 'sFAy3w0KVE8bs7blkzDdlQ'
	end

	def new_user(user)
		template_name = "welcome-email-test"
		template_content = []
		message = {
			to: [{email: "#{user.email}"}],
			subject: "Welcome to OneHourUX",
			merge_vars: [
				{
					rcpt: user.email,
					vars: [
						{name: "USER_NAME", content: user.first_name}
					]
				}
			]
		}

		mandrill_client.messages.send_template template_name, template_content, message
	end
end

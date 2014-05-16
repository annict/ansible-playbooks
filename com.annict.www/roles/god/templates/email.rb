# GmailのSMTPサーバでメール送信するためのモンキーパッチ
# https://coderwall.com/p/auiktq
Net::SMTP.class_eval do
  def initialize_with_starttls(*args)
    initialize_without_starttls(*args)
    enable_starttls
  end

  alias_method :initialize_without_starttls, :initialize
  alias_method :initialize, :initialize_with_starttls
end

God::Contacts::Email.defaults do |d|
  d.from_email      = ALERT_EMAIL_FROM
  d.from_name       = ALERT_EMAIL_FROM_NAME
  d.server_host     = 'smtp.mandrillapp.com'
  d.server_port     = 587
  d.server_auth     = :plain
  d.server_domain   = 'mandrillapp.com'
  d.server_user     = ALERT_EMAIL_FROM
  d.server_password = ALERT_EMAIL_FROM_PASSWORD
end

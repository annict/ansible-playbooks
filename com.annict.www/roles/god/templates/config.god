# メールで通知したいときに使用する設定
PROJECT_NAME              = '{{ god_project_name }}'
ALERT_EMAIL_FROM          = '{{ god_alert_email_from }}'
ALERT_EMAIL_FROM_NAME     = "Alert [#{PROJECT_NAME}]"
ALERT_EMAIL_FROM_PASSWORD = '{{ god_alert_email_from_password }}'

# 通知先の設定。このファイルの下で設定している `God.contact` 内の `c.name` の値を配列で指定する
ALERT_TO = ['shimba@email']

# Twilioを使用して電話で通知したいときに使用する設定
# TWILIO_ACCOUNT_SID       = ''
# TWILIO_AUTH_TOKEN        = ''
# TWILIO_FROM_NUMBER       = ''
# TWILIO_VOICE_MESSAGE_URL = ''

# DelayedJobなど、Bundleコマンドから起動するプロセスを監視するときに使用する設定
RAILS_ENV        = '{{ rails_env }}'
APPLICATION_ROOT = '{{ user_path }}'


# メール通知を行うための設定ファイルを読み込む
God.load '/etc/god/contacts/email.rb'
# 電話通知を行うための設定ファイルを読み込む
# God.load '/etc/god/contacts/twilio.rb'


# 連絡先の設定 1
God.contact(:email) do |c|
  c.name = 'shimba@email'
  c.to_email = 'bojovs@gmail.com'
end

# 連絡先の設定 2
# God.contact(:twilio) do |c|
#   c.name      = 'shimba@tel'
#   c.to_number = ''
# end


# 各種プロセスを監視するための設定ファイルを読み込む
God.load '/etc/god/config/*.god'

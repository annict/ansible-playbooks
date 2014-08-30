God.watch do |w|
  # 必須。ユニークに定義する必要がある
  w.name = "#{PROJECT_NAME}: DelayedJob"
  # プロセスをチェックする間隔
  w.interval = 30.seconds
  w.uid = '{{ user_name }}'
  w.gid = '{{ user_name }}'

  w.start = "/bin/bash -c 'cd #{APPLICATION_ROOT}/current; " +
            "RAILS_ENV=#{RAILS_ENV} " +
            "BUNDLE_GEMFILE=#{APPLICATION_ROOT}/current/Gemfile " +
            "bundle exec ./bin/delayed_job start'"
  w.log = "#{APPLICATION_ROOT}/shared/log/delayed_job.log"

  # 通常の監視に移行するまでの時間。オプション。
  w.start_grace = 30.seconds
  w.restart_grace = 30.seconds

  # start/stop/restart時のフックを指定。
  # :clean_pid_file とすると、stop時にpidファイルを削除してくれるようになる。
  w.behavior(:clean_pid_file)

  # pidファイルの場所を指定。監視したいプロセスがデーモンであれば指定する。
  w.pid_file = "#{APPLICATION_ROOT}/shared/pids/delayed_job.pid"

  w.start_if do |start|
    # プロセスを常時起動するようにする
    w.keepalive

    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
      c.notify = ALERT_TO
    end
  end
end

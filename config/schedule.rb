# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# Learn more: http://github.com/javan/whenever

set :output, 'log/cron_job.log'
env :PATH, ENV['PATH'] # Fix bundle exec not found issue

every 1.day, at: '8:00 pm' do
  rake 'sessions:remove_false_status', environment: 'development'
end

every 1.week do
  rake 'print:puts_until5', environment: 'development'
end

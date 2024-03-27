require_relative '../app/static/data'
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

job_type :rake, "cd #{APP_PATH} && bundle exec rake -f tasks/get_dazn_url.rake :task :output"

set :output, "#{APP_PATH}/log/cron.log"

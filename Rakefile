#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

relative_url_conf = File.expand_path('../config/initializers/relative_url', __FILE__)
require relative_url_conf if File.exist?("#{relative_url_conf}.rb")

Gitlab::Application.load_tasks

Knapsack.load_tasks if defined?(Knapsack)

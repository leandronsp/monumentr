set :stage, :staging
set :rails_env, 'staging'

role :app, %w(ubuntu@88.80.190.77)
role :web, %w(ubuntu@88.80.190.77)
role :db, %w(ubuntu@88.80.190.77)

server '88.80.190.77', user: 'ubuntu', roles: %w{app web db}

instance = ENV['INSTANCE'] || 'staging'

set :deploy_to, "/home/ubuntu/monumentr.#{instance}"

set :ssh_options, keys: [File.expand_path('~/.ssh/id_rsa')],
                  forward_agent: true, auth_methods: %w(publickey)

set :branch, %x`git rev-parse --abbrev-ref HEAD`.delete("\n")

set :puma_conf, "/home/ubuntu/monumentr.#{instance}/shared/puma.rb"

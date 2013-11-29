set :application, "Todo List"
set :repository,  "git@github.com:gschoeni/todoapp.git"

set :deploy_to, "/home/gschoeni/apps"

set :scm, :git
set :branch, "master"

set :user, "gschoeni"
set :scm_passphrase, "zoom2zoom!"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5
default_run_options[:pty] = true

server "www.curiousinspiration.com", :app, :web, :db, :primary => true

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  	desc "Symlink shared config files"
	task :symlink_config_files do
	    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
	end

	desc "Restart Passenger app"
	task :restart do
	    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
	end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
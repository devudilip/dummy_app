#############################################################
#	Application     
#############################################################

set :application, "dummy_app"
set :deploy_to, "/var/www/rails-test/devaraj/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, false

#############################################################
#	Servers
#############################################################

set :user, 'carmatec'
set :domain, "69.50.212.209"
set :port, "22"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Subversion
#############################################################

#set :repository,  "https://devudilip@github.com/devudilip/dummy_app.git"
#set :scm, "git"
#set :scm_username, "devudilip"
#set :scm_password, "asdfg"



set :scm, :git
set :repo_name, "#{application}.git"
set :repository, "https://devudilip@github.com/devudilip/dummy_app.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }
#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  after "deploy:update_code", :link_production_db
end

#after :deploy, "deploy:restart"

# database.yml task
desc "Link in the production database.yml"
task :link_production_db do
  run "ln -nfs #{deploy_to}shared/config/database.yml #{release_path}/config/database.yml"
#  run "ln -nfs #{deploy_to }/shared/db/sphinx #{release_path}/db/sphinx "
#  run "ln -nfs #{deploy_to}/shared/config/sphinx.yml #{release_path}/config/sphinx.yml"
#  run "ln -nfs #{deploy_to}/shared/config/newrelic.yml #{release_path}/config/newrelic.yml"

end
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

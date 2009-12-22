default_run_options[:pty] = true

set :application, "ta.wugeku.com"
set :repository,  "git@nowa.me:twap4r.git"

set :scm, :git
set :scm_passphrase, "nowacyn"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ta.wugeku.com"                          # Your HTTP server, Apache/etc
role :app, "ta.wugeku.com"                          # This may be the same as your `Web` server
role :db,  "ta.wugeku.com", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

set :deploy_to, "/var/www/vhosts/#{application}/deploy"

set :user, "root"
set :runner, "root"

namespace :deploy do
  task :start, :roles => :app do
    
  end
  task :stop, :roles => :app do
    
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
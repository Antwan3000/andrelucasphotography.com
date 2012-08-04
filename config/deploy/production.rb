#############################################################
#    Servers
#############################################################
server "andrelucasphotography.com", :web, :app, :db, :primary => true


#############################################################
#    Environment
#############################################################
set :deploy_env, 'production'


#############################################################
#    SSH
#############################################################
ssh_options[:username] = 'puma'
ssh_options[:port] = 22
ssh_options[:host_key] = 'ssh-rsa'
ssh_options[:forward_agent] = true
ssh_options[:keys] = %w(/home/puma/.ssh/authorized_keys)
#ssh_options[:verbose] = :debug


#############################################################
#    Passenger
#############################################################
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


#############################################################
#    Media
#############################################################
namespace :media do
  task :setup, :roles => :app, :except => { :no_release => true }  do
    run "mkdir -p #{shared_path}/media/videos"
    run "mkdir -p #{shared_path}/media/photos"
    run "mkdir -p #{shared_path}/docs"
  end
  task :symlink, :roles => :app, :except => { :no_release => true }  do
    run "ln -nfs #{shared_path}/media #{release_path}/public/media"
    run "ln -nfs #{shared_path}/docs #{release_path}/public/docs"
  end
end

after "deploy:setup",           "media:setup"   unless fetch(:skip_db_setup, false)
after "deploy:finalize_update", "media:symlink", "deploy:cleanup"


#############################################################
#    Test
#############################################################
task :uname do
  run "uname -a"
end
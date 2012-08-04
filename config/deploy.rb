#############################################################
#    RVM Bootstrap Settings
##############################################################
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p194@rails32'
set :rvm_type, :system


#############################################################
#    Bundler-Capistrano Bootstrap Settings
##############################################################
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'capistrano_colors'


#############################################################
#    Database Bootstrap Settings
##############################################################
# require File.expand_path('../database_deploy.rb', __FILE__)


#############################################################
#    Deployment Settings
#############################################################
set :application, "andrelucasphotography.com"
set :stages, %w(production staging)
set :default_stage, "staging"
set :deploy_to, "/var/www/projects/#{application}"
set :keep_releases, 3  ## Limited number of releases stored
set :use_sudo, false
default_run_options[:pty] = true


#############################################################
#    GIT Version Control
#############################################################
set :scm, :git
set :repository,  "git@github.com:Antwan3000/andrelucasphotography.com.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm_command, "/usr/bin/git"
set :scm_verbose, true
set :local_scm_command, :default
require 'rubygems'
require "rake/testtask"
require 'rake/gempackagetask' 
require 'rake/rdoctask' 
sdoc = begin 
  require 'sdoc'
  true
rescue Exception
  false
end

load 'render_inheritable.gemspec'

TEST_APP_ROOT  = File.join(File.dirname(__FILE__), 'test', 'test_app')

task :default => :test

desc "Run all tests"
task :test => ['test:app:init'] do
  Rake::TestTask.new do |test| 
    test.libs << "#{TEST_APP_ROOT}/test" 
    test.test_files = Dir[ "#{TEST_APP_ROOT}/test/**/*_test.rb" ] 
    test.verbose = true
  end
end

namespace :test do
  namespace :app do
    desc "Create a rails test application"
    task :create do
      unless File.exist?(TEST_APP_ROOT)
        sh "rails new #{TEST_APP_ROOT}"
      end
    end
          
    desc "Initializes the test application with a couple of classes"
    task :init => :create do
      FileUtils.cp_r(File.join(File.dirname(__FILE__), 'test', 'templates', '.'), TEST_APP_ROOT)
      FileUtils.cd(TEST_APP_ROOT) do
          sh "rake db:migrate db:test:prepare"
      end
    end
    
    task :environment => :init do
      ENV['RAILS_ROOT'] = TEST_APP_ROOT
      ENV['RAILS_ENV'] = 'test'
      
      require(File.join(TEST_APP_ROOT, 'config', 'environment'))
    end

  end
end

desc "Clean up all generated resources"
task :clobber do
  FileUtils.rm_rf(TEST_APP_ROOT)
end

desc "Install render_inheritable as a local gem." 
task :install => [:package] do
  sudo = RUBY_PLATFORM =~ /win32/ ? '' : 'sudo' 
  gem = RUBY_PLATFORM =~ /java/ ? 'jgem' : 'gem' 
  sh %{#{sudo} #{gem} install --no-ri pkg/render_inheritable-#{File.read('VERSION').strip}}
end

desc "Deploy rdoc to website"
task :site => :rdoc do
  if ENV['DEST']
  	sh "rsync -rzv rdoc/ #{ENV['DEST']}"
  else
  	puts "Please specify a destination with DEST=user@server:/deploy/dir"
  end
end

# :package task
Rake::GemPackageTask.new(RENDER_INHERITABLE_GEMSPEC) do |pkg|
  if Rake.application.top_level_tasks.include?('release')
    pkg.need_tar_gz = true 
    pkg.need_tar_bz2 = true 
    pkg.need_zip  = true
  end 
end

# :rdoc task
Rake::RDocTask.new do |rdoc| 
  rdoc.title  = 'Render Inheritable' 
  rdoc.options << '--line-numbers' << '--inline-source'
    if sdoc
      rdoc.options << '--fmt' << 'shtml'
      rdoc.template = 'direct'
    end
  rdoc.rdoc_files.include(*FileList.new('*') do |list|
    list.exclude(/(^|[^.a-z])[a-z]+/)
    list.exclude('TODO') 
    end.to_a)
  rdoc.rdoc_files.include('lib/**/*.rb') 
  rdoc.rdoc_files.exclude('TODO') 
    
  rdoc.rdoc_dir = 'rdoc'
  rdoc.main = 'README.rdoc' 
end
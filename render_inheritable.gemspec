require 'rubygems' 
require 'rake'
require 'date'

RENDER_INHERITABLE_GEMSPEC = Gem::Specification.new do |spec| 
	spec.name    = 'render_inheritable' 
	spec.version = File.read('VERSION').strip
	spec.date    = Date.today.to_s
	
	spec.author   = 'Pascal Zumkehr'
	spec.email    = 'spam@codez.ch' 
	spec.homepage = 'http://codez.ch/render_inheritable'
		
	spec.summary = "A Rails 3 plugin that allows one to inherit or override single templates for controller hierarchies."
	spec.description = <<-END
With this gem, a template is searched in the current controller's view folder (as usual). 
If it is not found there, the template with the same name in the view folder of the 
superclass controller is used. Finally, also views and partials remain DRY!
END

	readmes = FileList.new('*') do |list|
		list.exclude(/(^|[^.a-z])[a-z]+/) 
		list.exclude('TODO') 
	end.to_a 
	spec.files = FileList['lib/**/*', 'test/templates/**/*', 'Rakefile'].to_a + readmes 
    spec.require_path = 'lib'
    
	spec.has_rdoc = true 
	spec.extra_rdoc_files = readmes 
	spec.rdoc_options += [
'--title', 'Render Inheritable', '--main', 'README.rdoc', '--line-numbers', '--inline-source'
] 
end
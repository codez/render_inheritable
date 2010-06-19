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
		
	spec.summary = "A Rails plugin that allows one to inherit or override single partials and templates for controller subclasses."
	spec.description = <<-END
render inheritable
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
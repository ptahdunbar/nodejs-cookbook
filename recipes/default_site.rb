
include_recipe 'git'
include_recipe 'runit'

directory node[:nodejs][:default_site_dir] do
	recursive true
end

if node[:nodejs][:default_site_enabled]
	git node[:nodejs][:default_site_dir] do
		repository node[:nodejs][:default_site_repository]
		reference node[:nodejs][:default_site_reference]
		action :sync
		notifies :run, "bash[enable_default_site]"
	end
end

bash "enable_default_site" do
	cwd node[:nodejs][:default_site_dir]
	command "npm install"
	command "grunt"
	action :nothing
end

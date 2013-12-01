
if node[:nodejs][:apps]
	Chef::Log.info "[nodejs] apps: #{node[:nodejs][:apps]}"

	node[:nodejs][:apps].each do |app|

		name = app["name"] ? app["name"] : app;

		nodejs_app name do
			root app["root"] if app["root"]
			root app["start"] if app["start"]
		end

	end
end
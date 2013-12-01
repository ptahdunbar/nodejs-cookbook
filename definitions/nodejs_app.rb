define :nodejs_app, :enabled => true, :user => 'root', :group => nil, :template => 'init.d.erb' do

	params["root"] = params["root"] ? params["root"] : "#{node[:nodejs]["root"]}/#{params[:name]}"
	params["start-script"] = params["start"] ? params["start"] : "#{params["root"]}/#{node[:nodejs][:default_start_script]}"
	params["pid-file"] = params["pid-file"] ? params["pid-file"] : "#{params["root"]}/#{node[:nodejs][:default_pid_file]}"
	params["log-file"] = params["log-file"] ? params["log-file"] : "#{params["root"]}/#{node[:nodejs][:default_log_file]}"
	params[:group] = params[:group] ? params[:group] : params[:user]

	# Make sure that the declared service user exists.
    #
    # Note that the service launches as root: it is the responsibility of the
    # service to switch to using the declared user. We just need to know here so
    # that we can set up the log directory.
    user params[:user]

    # Set up directories.
    paths = [ params["root"], File.dirname(params["pid-file"]), File.dirname(params["log-file"]) ]
    paths.each do |dir|
		directory dir do
			action :create
			owner params[:user]
			group params[:group]
			mode 00775
			recursive true
			not_if { ::File.exists?(dir) }
		end
    end

    # Install a service definition to /etc/init.d.
    service params[:name] do
		supports [:restart, :status]
		action :nothing
    end

	template "/etc/init.d/#{params[:name]}" do
		source params[:template]
		owner 'root'
		group 'root'
		mode 00755
		variables(
			:params => params
		)
		notifies :enable, resources(:service => params[:name])
		notifies :start, resources(:service => params[:name]) if params[:enabled]
	end

end
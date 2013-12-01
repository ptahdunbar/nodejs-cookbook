#
# Cookbook Name:: nodejs
# Attributes:: nodejs
#
# Copyright 2010-2012, Promet Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node[:platform_family]
  when "smartos"
    default[:nodejs][:install_method] = 'package'
  else
    default[:nodejs][:install_method] = 'source'
end

default[:nodejs][:version] = '0.10.22'
default[:nodejs][:checksum] = 'b4433b98f87f3f06130adad410e2fb5f959bbf37'
default[:nodejs][:checksum_linux_x64] = '3739f75bbb85c920a237ceb1c34cb872409d61f7'
default[:nodejs][:checksum_linux_x86] = '7e99b654c21bc2a5cbccc33f1bae3ce6e26b3d12'
default[:nodejs][:dir] = '/usr/local'
default[:nodejs][:npm] = '1.3.15'
default[:nodejs][:src_url] = "http://nodejs.org/dist"
default[:nodejs][:make_threads] = node[:cpu] ? node[:cpu][:total].to_i : 2
default[:nodejs][:check_sha] = true

# Default values for building Node.js from source with no special settings
# used for the make install step.
default[:nodejs][:bin] = "#{node[:nodejs][:dir]}/bin"
default[:nodejs][:global_modules_dir] = "#{node[:nodejs][:dir]}/node_modules"
default[:nodejs][:root] = '/srv/www'
default[:nodejs][:default_start_script] = 'server.js'
default[:nodejs][:default_pid_file] = 'server.pid'
default[:nodejs][:default_log_file] = 'server.log'

# Set this to true to install the legacy packages (0.8.x) from ubuntu/debian repositories; default is false (using the latest stable 0.10.x)
default[:nodejs][:legacy_packages] = false

#TODO deleteme. support generic app
default[:nodejs][:default_site_enabled] = false
default[:nodejs][:default_site_dir] = '/srv/www/mean'
default[:nodejs][:default_site_repository] = 'git://github.com/linnovate/mean.git'
default[:nodejs][:default_site_reference] = 'master'

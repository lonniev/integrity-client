#
# Cookbook Name:: integrity-client
# Recipe:: default
#
# Copyright 2014, Lonnie VanZandt
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

package "rar" do
  action :upgrade
end
  
package "unrar" do
  action :upgrade
end

directory "#{node['integrity-client']['zipDir']}" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute "reassemble zip from rar fragments" do
  command "unrar x -y #{node['integrity-client']['rarFile']} #{node['integrity-client']['zipDir']}"
  creates #{node['integrity-client']['zipFile']}
end

execute "unzip the installer" do
  command "cd #{node['integrity-client']['zipDir']}; unzip #{node['integrity-client']['zipFile']}"
  creates #{node['integrity-client']['zipDir']}/mksclient.bin
end

directory "#{node['integrity-client']['installDir']}" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute "silently install the client" do
  command "./mksclient.bin -DinstallLocation=#{node['integrity-client']['installDir']} -i silent"
  creates #{node['integrity-client']['installDir']}/bin/IntegrityClient
end

directory "#{node['integrity-client']['zipDir']}" do
  action :delete
end




    

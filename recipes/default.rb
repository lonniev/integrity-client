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

include_recipe "manage-users"

package "rar" do
  action :upgrade
end
  
package "unrar" do
  action :upgrade
end

package "unzip" do
  action :upgrade
end

zipDir = File.expand_path( node['integrity-client']['zipDir'] )

directory "#{zipDir}" do
  owner 'root'
  group 'root'
  mode '0644'
  recursive true
  action :create
end

rarFile = File.expand_path( node['integrity-client']['rarFile'] )
zipFile = node['integrity-client']['zipFile']

execute "reassemble zip from rar fragments" do
  command "unrar x -y #{rarFile} #{zipDir}"
  creates "#{zipDir}/#{zipFile}"
end

execute "unzip the installer #{zipFile}" do
  cwd zipDir
  command "unzip #{zipFile}"
  creates "#{zipDir}/mksclient.bin"
end

installDir = File.expand_path( node['integrity-client']['installDir'] )

directory "#{installDir}" do
  owner 'root'
  group 'root'
  mode '0644'
  recursive true
  action :create
end

link "/lib/libc.so.6" do
  to "/lib/i386-linux-gnu/libc.so.6"
  only_if "test -f /lib/i386-linux-gnu/libc.so.6"
  not_if "test -f /lib/libc.so.6"
end

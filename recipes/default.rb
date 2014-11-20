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

node['integrity-client']['clients'].each do |clientSpec|
    
  clientSpec.each do |clientName, repo|
    
    getHomeCmd = Mixlib::ShellOut.new("useradd -D|grep HOME|cut -d '=' -f 2")
    getHomeCmd.run_command

    homeDir = getHomeCmd.stdout.chomp
    
    gitUserName = repo['user']['username']
    userHomePath = "#{homeDir}/#{gitUserName}"
    
    user gitUserName do
        action   :create
        username gitUserName
        password repo['user']['password']
        comment  repo['user']['fullname']
        home     userHomePath
        shell    repo['user']['shell'] || '/bin/bash'
    end
    
    directory userHomePath do
        owner gitUserName
        group gitUserName
        recursive true
        action :create
    end
    
    directory "#{userHomePath}/Downloads" do
        owner gitUserName
        group gitUserName
        recursive true
        action :create
    end
    
   destPath = repo['destination'].sub( /~/, "#{homeDir}/" )
    
    directory destPath do
        owner gitUserName
        group gitUserName
        recursive true
        action :create
    end

    destPath = ::File.expand_path( destPath )

    remote_file destFile
        source "#{url}?dlm=no&wcn=#{wcn}&cn=#{cn}&uname=#{uname}&uid=#{uid}&__gda__=#{gda}&ext=.zip"
        
        headers { "Authorization" => "Basic #{encodedPassword}" }

        owner gitUserName
        group gitUserName
        mode 0666
        
        action :create_if_missing
    end
  
    log "message" do
        message "Downloaded #{clientName} for user #{gitUserName} into #{destPath}."
        level :info
    end
  end
end
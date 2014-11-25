#
# Cookbook Name:: integrity-client
# Recipe:: default
#
# Copyright 2014, Lonnie VanZandt lonniev@gmail.com
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

default['integrity-client']['rarFile'] = "/opt/vagrant/installables/IntegrityClient.part1.rar"
default['integrity-client']['zipDir'] = "~/ziptmp"
default['integrity-client']['zipFile'] = "MED-60958-CD-106_F000_Integrity-10-6-Client-Linux32.zip"
default['integrity-client']['installDir'] = "/opt/Integrity/IntegrityClient10"

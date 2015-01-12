#
# Cookbook Name:: apache2
# Recipe:: mod_security
#
# Copyright 2008-2013, Opscode, Inc.
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

case node['platform_family']
when 'rhel'
  if node['apache']['version'] == '2.4'
    package 'mod24_security' do
      action :install
      notifies :run, resources(execute: 'generate-module-list'), :immediately
    end
  else
    package 'mod_security' do
      action :install
      notifies :run, resources(execute: 'generate-module-list'), :immediately
    end
  end

  file "#{node['apache']['dir']}/conf.d/mod_security.conf" do
    action :delete
    backup false
  end

when 'debian'
  # TODO Debian / Ubuntu install
end

apache_module 'security2' do
  conf true
end

# Cookbook Name:: oracle-instantclient
# Provider:: AlienDpkg
# Author:: David Kinzer <dtkinzer@gmail.com>
#
# Copyright (C) 2014 David Kinzer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'chef/provider/package'
require 'chef/provider/package/dpkg'
require_relative 'mixin_alien_converter'

class Chef
  class Provider
    # Alien wrapper to the Dpkg package provider.
    class AlienDpkg < Chef::Provider::Package::Dpkg
      include Chef::Mixin::AlienConverter

      def initialize(new_resource, run_context)
        super
        Chef::Log.info("Run Context #{run_context}")
        @new_resource.source alien_package_debian_source
        alien_log_convert
      end
    end
  end
end

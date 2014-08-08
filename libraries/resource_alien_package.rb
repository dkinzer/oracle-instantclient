# Cookbook Name:: oracle-instantclient
# Resource:: alien_convert
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
#
require 'chef/provider/package/yum'
require_relative 'provider_alien_dpkg'

class Chef
  class Resource
    # Resource definition for alien_convert.
    class AlienPackage < Chef::Resource::Package
      def initialize(name, run_context = nil)
        super
        @resource_name = initial_name
        @provider = initial_provider
      end

      def initial_name
        if platform_family? 'rhel'
          :yum_package
        else
          :alien_package
        end
      end

      def initial_provider
        if platform_family? 'rhel'
          Chef::Provider::Package::Yum
        else
          Chef::Provider::Package::AlienDpkg
        end
      end
    end
  end
end

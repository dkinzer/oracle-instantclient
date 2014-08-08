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
require 'chef/resource/execute'
require_relative 'provider_alien_convert'

class Chef
  class Resource
    # Resource definition for alien_convert.
    class AlienConvert < Chef::Resource::Execute
      def initialize(name, run_context = nil)
        super
        @resource_name = :alien_convert
        @source = name
        @action = :convert
        @allowed_actions.push(:convert)
        @provider = Chef::Provider::AlienConvert
      end

      def source(arg = nil)
        set_or_return(
          :source,
          arg,
          :kind_of => String
        )
      end
    end
  end
end

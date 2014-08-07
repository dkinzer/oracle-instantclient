# Cookbook Name:: oracle-instantclient
# Mixin:: alien_converter
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

class Chef
  module Mixin
    # Base functionality module for generating the alien shell command.
    module AlienConverter
      def alien_log_convert
        if !::File.exists? alien_package_debian_source
          Chef::Log.info("Alien converting package to - #{alien_package_debian_source}.")
          alien_convert
        else
          Chef::Log.info("Converted package present - #{alien_package_debian_source}.")
        end
      end

      def alien_convert
        shell_out!(*alien_command)
      end

      def alien_command
        "alien #{alien_package_name}"
      end

      def alien_package_debian_source
        File.join(alien_package_directory, alien_package_debian_name)
      end

      def alien_package_debian_name
        name = String.new alien_package_name
        version = String.new alien_package_version
        name.gsub("-#{version}.x86_64.rpm", "_#{version}_amd64.deb")
      end

      def alien_package_name
        File.basename(alien_package_source_path)
      end

      def alien_package_version
        alien_package_source_path.match(/(\d+\.)+(\d+-\d*)*/)[0]
      end

      def alien_package_directory
        File.dirname(alien_package_source_path)
      end

      def alien_package_source_path
        new_resource.source
      end
    end
  end
end

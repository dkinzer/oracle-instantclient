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
#
# Override the shell_out method.
#
require 'minitest/autorun'
require 'chef/resource/dpkg_package'
require_relative '../../libraries/provider_alien_dpkg'

# Override shell_out method.
class Chef::Provider::AlienDpkg
  def shell_out!(command, opts = [])
    command
  end
end

# Unit tests for Chef::Provider::AlienConvert
class TestProviderAlienDpkg < MiniTest::Test
  def setup
    new_resource = Chef::Resource::DpkgPackage.new 'A-fake-rpm-package'
    new_resource.source '/foo/bar/fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
    @provider = Chef::Provider::AlienDpkg.new new_resource, nil
  end

  def test_source_initialization
    expected = '/foo/bar/fake-package12.1-basic_12.2.3.4.5-0_amd64.deb'
    actual = @provider.new_resource.source
    assert_equal expected, actual
  end
end

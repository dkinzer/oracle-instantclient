# Cookbook Name:: oracle-instantclient
# Resource:: alien_package
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
require 'minitest/autorun'
require 'chef/dsl/platform_introspection'
require_relative '../../libraries/resource_alien_package'

# Override platform_family?
class Chef::Resource::AlienPackage
  def platform_family?(family)
    true
  end
end

# Unit test Chef::Resource::AlienPackage.
class TestResourceAlienPackage < MiniTest::Test
  def setup
    fake_rpm = '/foo/bar/fake-package-1.2.3.4-0.x86_64.rpm'
    @resource = Chef::Resource::AlienPackage.new fake_rpm
  end

  def test_init_when_rhel
    expected = Chef::Provider::Package::Yum
    actual = @resource.initial_provider
    assert_equal  expected, actual, 'The correct provider is set.'

    expected = :yum_package
    actual = @resource.initial_name
    assert_equal expected, actual, 'The correct resource name is set.'
  end

  def test_init_when_debian
    @resource.stub :platform_family?, false do
      expected = Chef::Provider::Package::AlienDpkg
      actual = @resource.initial_provider
      assert_equal  expected, actual, 'The correct provider is set.'

      expected = :alien_package
      actual = @resource.initial_name
      assert_equal expected, actual, 'The correct resource name is set.'
    end
  end
end

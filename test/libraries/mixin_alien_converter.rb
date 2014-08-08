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
#
require 'minitest/autorun'
require 'minitest/mock'
require_relative '../../libraries/mixin_alien_converter'
require_relative '../../libraries/resource_alien_convert'

# Allow tests to run in a mock provider.
class MockProvider < Chef::Provider
  include Chef::Mixin::AlienConverter

  def shell_out!(command)
    command
  end
end

# Unit tests for Chef::Mixin::AlienConverter.
class TestAlienConverter < MiniTest::Test
  def setup
    fake_rpm = '/foo/bar/fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
    resource = Chef::Resource::AlienConvert.new fake_rpm
    resource.source  '/foo/bar/fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
    @provider = MockProvider.new resource, nil
  end

  def test_alien_log_convert_file_exists
    File.stub :exists?, true do
      message = 'Converted package present - /foo/bar/fake-package12.1-basic_12.2.3.4.5-0_amd64.deb'
      expected = Chef::Log.info(message)
      actual = @provider.alien_log_convert
      assert_equal expected, actual
    end
  end

  def test_alien_log_convert_not_file_exists
    File.stub :exists?, false do
      expected = 'alien fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
      actual = @provider.alien_log_convert
      assert_equal expected, actual
    end
  end

  def test_alien_convert
    expected = 'alien fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
    actual = @provider.alien_convert
    assert_equal expected, actual
  end

  def test_alien_command
    expected = 'alien fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
    actual = @provider.alien_command
    assert_equal expected, actual
  end

  def test_alien_package_debian_source
    expected = '/foo/bar/fake-package12.1-basic_12.2.3.4.5-0_amd64.deb'
    actual = @provider.alien_package_debian_source
    assert_equal expected, actual
  end

  def test_alien_package_version
    expected = '12.2.3.4.5-0'
    actual = @provider.alien_package_version
    assert_equal expected, actual
  end

  def test_alien_source_filename
    expected = 'fake-package12.1-basic-12.2.3.4.5-0.x86_64.rpm'
    actual = @provider.alien_source_filename
    assert_equal expected, actual
  end

  def test_alien_package_debian_filename
    expected = 'fake-package12.1-basic_12.2.3.4.5-0_amd64.deb'
    actual = @provider.alien_package_debian_filename
    assert_equal expected, actual
  end

  def test_alien_package_directory
    expected = '/foo/bar'
    actual = @provider.alien_package_directory
    assert_equal expected, actual
  end
end

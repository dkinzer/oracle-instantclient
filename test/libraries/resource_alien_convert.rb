# Cookbook Name:: oracle-instantclient
# Resource:: alien_converter
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
require_relative '../../libraries/resource_alien_convert'

# Override the shell_out method.
class Chef::Resource::AlienConvert
  def shell_out!(command, options = [])
    command
  end

  def converge_by(description, &block)
    instance_eval(&block)
  end
end

# Unit tests for Chef::Provider::AlienConvert
class TestResourceAlienConvert < MiniTest::Test
  def setup
    fake_rpm = '/foo/bar/fake-package-1.2.3.4-0.x86_64.rpm'
    @resource = Chef::Resource::AlienConvert.new fake_rpm
  end

  def test_action_initialization
    expected = :convert
    actual = @resource.action
    assert_equal expected, actual
  end

  def test_allowed_actions_initialization
    assert @resource.allowed_actions.include?(:convert)
  end

  def test_provider_initialization
    expected = Chef::Provider::AlienConvert
    actual = @resource.provider
    assert_equal expected, actual
  end

  def test_source_initialization
    expected = '/foo/bar/fake-package-1.2.3.4-0.x86_64.rpm'
    actual = @resource.source
    assert_equal expected, actual
  end
end

#
# Cookbook Name:: example
# Recipe:: default
#
# Copyright (c) 2015 UMass Transit, All Rights Reserved.
log 'example_message' do
  message 'This is an example cookbook.  Remove it and create your own.'
  level :warn
end

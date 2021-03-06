=begin #(fold)
++
Copyright 2004-2007 Joyent Inc.

Redistribution and/or modification of this code is 
governed by the GPLv2.

Report issues and contribute at http://dev.joyent.com/

$Id$
--
=end #(end)

class CreateStrongspaceAndServicesFolders < ActiveRecord::Migration
  def self.up
    User.find(:all).each do |user|
      FileUtils.mkdir_p(File.join(user.services_root_path, 'lightning'))
    end
  end

  def self.down
  end
end

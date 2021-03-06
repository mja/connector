=begin #(fold)
++
Copyright 2004-2007 Joyent Inc.

Redistribution and/or modification of this code is 
governed by the GPLv2.

Report issues and contribute at http://dev.joyent.com/

$Id$
--
=end #(end)

class CreateUserOptions < ActiveRecord::Migration
  def self.up
    create_table :user_options do |t|
      t.column :user_id, :integer
      t.column :key,     :text, :default => ''
      t.column :value,   :text, :default => ''
    end
  end

  def self.down
    drop_table :user_options
  end
end

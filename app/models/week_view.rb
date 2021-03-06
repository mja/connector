=begin #(fold)
++
Copyright 2004-2007 Joyent Inc.

Redistribution and/or modification of this code is 
governed by the GPLv2.

Report issues and contribute at http://dev.joyent.com/

$Id$
--
=end #(end)

class WeekView < BaseView
  attr_reader :start_of_week
  
  def initialize(date, start_of_week, current_user)
    @start_of_week  = start_of_week
    date           -= (date.wday - start_of_week) % 7 # Determine the first date for the week
    @days           = Array.new
    (0..6).each{|num| @days << DayView.new(date+num, current_user)}
    super(date, @days[0].start_time, @days[-1].end_time, current_user)
  end

  def events
    @days.collect(&:events).flatten.sort
  end

  def others_events_length
    @days.collect(&:others_events).collect(&:values).flatten.reject{|a| a.blank?}.length
  end

  def each(&block)
    @days.each{|day| yield day}
  end
  
  alias each_day each
  
  def take_events(events)
    @days.each {|d| d.take_events events}
  end
  
  def take_others_events(user, events)
    @days.each {|d| d.take_others_events(user, events)}
  end
end
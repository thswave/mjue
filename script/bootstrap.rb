#!/usr/bin/env ruby

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)

require File.expand_path('../lectures', __FILE__)

@lectures.each do |lecture|
  l = Lecture.new
  l.level = lecture[0]
  l.title = lecture[1]
  l.credit = lecture[2]
  l.provider = lecture[3]
  l.department = lecture[4]
  l.save
end

Lecture.import

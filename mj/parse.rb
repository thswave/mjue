# encoding: utf-8

require 'nokogiri'
require 'iconv'
require 'table_parser'

module TableParser
  class Table
    def each
      return unless block_given?
      @columns.each { |c| yield c }
    end
  end

  class TableColumn
    def to_a
      @children
    end
  end

  class TableNode
    def to_s
      @text
    end
  end
end

base = File.dirname(__FILE__)

def parse(filename)
  f = File.open(filename, 'r')
  body = Iconv.conv('utf-8', 'euc-kr', f.read)
  doc = Nokogiri::HTML body

  table = TableParser::Table.new doc, '//table', header: false

  cols = []

  table.each do |colgroup|
    cols << colgroup.to_a
  end

  rows = {}

  cols.each do |col|
    col.each_with_index do |entry, i|
      rows[i] ||= []
      rows[i] << entry.to_s
    end
  end

  # puts filename
  # department = Iconv.conv('utf-8//ignore', 'latin', filename).match(/[^\/]+\.htm/).to_s.gsub(/\.htm/, '')
  department = ''
  rows.each do |i, row|
    if row[1] =~ /2012/
      as = row[1].split(' ')
      as.shift
      as.shift
      as.shift
      as.shift
      department = as.join ''
    end
    next if row[1].nil? || row[2].nil? || row[1].strip.empty? || row[2].strip.empty? || row[5].strip.empty? || row[7].strip.empty? || row[2].match('학기') || row[1].match('학년도') || row[1] == '학년'
    puts "[\'" + [row[1], row[2], row[5], row[7],department].join("\',\'") + "\'],"
  end
end

Dir.entries(base).each do |entry|
  next if entry == '.' || entry == '..'

  if File.directory?(File.join(base, entry))
    Dir.entries(File.join(base, entry)).each do |inner_entry|
      next unless inner_entry =~ /.+\.htm/

      parse(File.join(base, entry, inner_entry))
    end
  end
end

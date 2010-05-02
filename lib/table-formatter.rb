#!/usr/bin/ruby

class TableFormatter

  attr_accessor :source, :labels
  
  def initialize()    
  end
  
  def display
    a = @source
    labels = @labels
    column_widths = fetch_column_widths(a)
    records = format_rows(a.clone, column_widths)
    div = '-' * records[0].length + "\n"
    label_buffer = ''    
    label_buffer = format_cols(labels, column_widths) + "\n" + div if labels
    div + label_buffer + records.join("\n") + "\n" + div
  end

  private
  
  def tabulate(a)
    a[0].zip(a.length > 2 ? tabulate(a[1..-1]) : a[-1])
  end

  def fetch_column_widths(a)
    d = tabulate(a).map &:flatten

    # find the maximum lengths
    d.map{|x| x.max_by(&:length).length}
  end

  def format_cols(row, col_widths)
    buffer = '|'
    row.each_with_index do |col, i|
      buffer += ' ' + col.ljust(col_widths[i] + 2) + '|'    
    end
    buffer
  end

  def format_rows(a, col_widths)
    a.map {|row| format_cols(row, col_widths)}
  end
end

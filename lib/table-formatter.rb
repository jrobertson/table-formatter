#!/usr/bin/env ruby

# file: table-formatter.rb

class TableFormatter

  attr_accessor :source, :labels, :border, :divider
  
  def initialize(opt={})    

    o = {source: nil, labels: nil, border: true, nowrap: false}.merge(opt)
    super()
    @source = o[:source]
    @raw_labels = o[:labels] if o[:labels]
    @border = o[:border]
    @nowrap = o[:nowrap]
    @divider = o[:divider] if o[:divider]
    @maxwidth = 60
  end
  
  def display(width=nil)

    if @raw_labels then

      @align_cols, @labels = [], []

      @raw_labels.each do |raw_label|

        col_just, label = just(raw_label)
        @align_cols << col_just
        @labels << label
      end

    end

    #width ||= @maxwidth
    @width = width
    @maxwidth = width if width
    a = @source.map {|x| x.map.to_a}.to_a
    labels = @labels

    column_widths = fetch_column_widths(a)

    column_widths[-1] -= column_widths.inject(&:+) - width if width

    records = format_rows(a, column_widths)

    div =  (border == true ? '-' : '') * records[0].length + "\n"
    label_buffer = ''

    label_buffer = format_cols(labels, column_widths) + "\n" + div if labels

    div + label_buffer + records.join("\n") + "\n" + div

  end

  alias to_s display

  def labels=(a)
    @raw_labels = a
  end

  private
  
  def fetch_column_widths(a)

    d = tabulate(a).map &:flatten

    # find the maximum lengths
    d.map{|x| x.max_by(&:length).length}
  end

  def format_cols(row, col_widths)
    bar = ''
    bar = '|' if border == true
    bar = divider if divider

    buffer = divider ? '' : bar #unless divider
    row.each_with_index do |col, i|

      align = @align_cols ? @align_cols[i] : :ljust
      buffer += col.method(align).call(col_widths[i] + 2) + bar
    end
    buffer.sub!(/#{bar}$/,'') if divider
    buffer
  end

  def format_rows(a, col_widths)

    @width = col_widths.inject(&:+)

    col_widths[-1] -= col_widths.inject(&:+) - @maxwidth if @width > @maxwidth

    a.each_with_index do |x,i|
      col_rows = @nowrap == false ? wrap(x[-1], col_widths[-1]).split(/\n/) : [x[-1]]
      if col_rows.length > 1 then
        x[-1] = col_rows[0]
        col_rows[1..-1].map.with_index {|y,j| a.insert(i+1+j, Array.new(x.length - 1,'') + [y])}
      end
    end

    a.map {|row| format_cols(row, col_widths)}
  end

  def just(x)

    case x
      when /^:.*:$/
        [:center, x[1..-2]]
      when /:$/
        [:rjust, x[0..-2]]
      when /^:/
        [:ljust, x[1..-1]]
      else
        [:ljust, x]
    end
  end

  def tabulate(a)
    a[0].zip(a.length > 2 ? tabulate(a[1..-1]) : a[-1])
  end

  def wrap(s, col=@maxwidth)
    s.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/,
      "\\1\\3\n") 
  end

end
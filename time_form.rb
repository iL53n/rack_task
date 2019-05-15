class TimeFormat

  attr_reader :time_format, :unknown_formats

  FORMATS = {
      'year'   => '%Y',
      'month'  => '%m',
      'day'    => '%d',
      'hour'   => '%H',
      'minute' => '%M',
      'second' => '%S'
  }.freeze

  def initialize(params)
    @time_format = []
    @unknown_formats = []
    set_time_format(params['format'].split(','))
  end

  def valid?
    @unknown_formats.empty?
  end

  def call
    Time.now.strftime(@time_format.join('-'))
  end

  private

  def set_time_format(params)
    params.each do |format|
      if FORMATS[format]
        @time_format << FORMATS[format]
      else
        @unknown_formats << format
      end
    end
  end
end
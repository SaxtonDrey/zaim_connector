require "csv"
require "yaml"

class ZaimConnector
  def initialize(type:, start_at:, end_at:)
    @type = type
    @start_at = start_at
    @end_at = end_at
    @config = YAML.load_file("./config/#{@type}.yml")
  end
  
  def convert
    CSV.open("./output/#{output_file_name}", "wb") do |csv|
      input_csv.each do |row|
        csv << [
          parse_time(row[time_column_index]).strftime("%Y年%m月%d日"),
          row[description_column_index],
          row[shop_name_column_index],
          row[payment_amount_column_index]
        ]
      end
    end
  end

  def input_csv
    @input_csv = CSV.read("./datasource/#{@type}.csv").drop_while do |row|
      @end_at < parse_time(row[time_column_index])
    end.take_while do |row|
      parse_time(row[time_column_index]) > @start_at
    end
  end

  def parse_time(time_column)
    Time.strptime(time_column, time_format)
  end

  def output_file_name
    "#{@type}_#{@start_at.strftime("%Y-%m-%d-%H-%M")}_#{@end_at.strftime("%Y-%m-%d-%H-%M")}"
  end

  %i(description_column_index shop_name_column_index payment_amount_column_index time_column_index time_format).each do |config_name|
    define_method(config_name) do
      @config[config_name.to_s]
    end
  end
end
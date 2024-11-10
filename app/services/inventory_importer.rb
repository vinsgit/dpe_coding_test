require 'csv'

class InventoryImporter
  module Errors
    class CsvImportError < StandardError; end
  end

  REQUIRED_HEADERS = %w[NAME CATEGORY QTY DEFAULT_PRICE].freeze

  def initialize(file_path)
    @file_path = file_path
  end

  def import
    csv_data = read_file
    validate_headers!(csv_data.headers)

    csv_data.each do |row|
      process_row!(row)
    rescue StandardError => e
      log_error(row, e)
    end
  end

  private

  def read_file
    ::CSV.read(@file_path, headers: true)
  end

  def validate_headers!(headers)
    missing_headers = REQUIRED_HEADERS - headers
    raise Errors::CsvImportError, "Missing required headers: #{missing_headers.join(', ')}" if missing_headers.any?
  end

  def process_row!(row)
    category = find_or_initialize_category(row['CATEGORY'])
    product = find_or_initialize_product(row, category.id)

    product.qty = row['QTY'].to_i
    product.default_price = row['DEFAULT_PRICE'].to_f

    product.save!
  end

  def find_or_initialize_category(category_name)
    Category.find_or_create_by(name: category_name)
  end

  def find_or_initialize_product(row, category_id)
    Product.find_or_initialize_by(name: row['NAME'], category_id: category_id)
  end

  def log_error(row, error)
    Rails.logger.error "Failed to process row: #{row.to_h}, error: #{error.message}"
  end
end

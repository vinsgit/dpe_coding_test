class CsvValidator
  VALID_CONTENT_TYPE = "text/csv".freeze

  def initialize(file)
    @file = file
  end

  def valid?
    validate_presence
    validate_content_type
    true
  end

  private

  def validate_presence
    raise InventoryImporter::Errors::CsvImportError, "File is missing!" unless @file.present?
  end

  def validate_content_type
    raise InventoryImporter::Errors::CsvImportError, "Invalid file type!" unless @file.content_type == VALID_CONTENT_TYPE
  end
end

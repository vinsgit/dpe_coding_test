module Errors
  class ProductImportError < StandardError; end
  class OutOfStockError < StandardError; end
  class NoCartError < StandardError; end
  class UnauthorizedError < StandardError; end
  class CartAlreadyPlacedError < StandardError; end
  class CsvImportError < StandardError; end
  class InvalidNameError < StandardError; end
end

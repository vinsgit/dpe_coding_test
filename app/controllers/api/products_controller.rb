module Api
  class ProductsController < ActionController::API
    rescue_from InventoryImporter::Errors::CsvImportError, with: :handle_import_error

    def index
      products = Product.all
      render json: products, each_serializer: ProductSerializer
    end

    def show
      product = Product.find(params[:id])
      render json: product, serializer: ProductSerializer
    end

    def import
      if csv_validator.valid?
        import_service.import
        render json: { message: 'success' }, status: :ok
      end
    end

    private

    def csv_validator
      CsvValidator.new(params[:inventory_file])
    end

    def import_service
      InventoryImporter.new(params[:inventory_file])
    end

    def handle_import_error(error)
      render json: { message: error.message }, status: :unprocessable_entity
    end
  end
end

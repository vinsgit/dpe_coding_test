module Api
  class ProductsController < ApplicationController
    rescue_from Errors::CsvImportError,
                Errors::UnauthorizedError,
                Errors::ProductImportError,
                InventoryImporter::Errors::CsvImportError,
                Errors::InvalidNameError,
                with: :handle_error

    before_action :authenticate_user, only: [:import]

    def index
      products = Product.all
      render json: products, each_serializer: ProductSerializer
    end

    def show
      product = Product.find(params[:id])
      render json: product, serializer: ProductSerializer
    end

    def import
      raise Errors::UnauthorizedError, 'Unauthorized!' unless current_user&.admin?

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
  end
end

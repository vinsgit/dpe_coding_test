module Api
  class CartsController < ApplicationController
    before_action :authenticate_user

    rescue_from Errors::OutOfStockError,
                Errors::NoCartError,
                Errors::CartAlreadyPlacedError,
                Errors::InvalidNameError,
                with: :handle_error

    before_action :authenticate_user

    def add
      add_to_cart_service.call

      render json: current_cart, serializer: CartSerializer, status: :ok
    end

    def place_order
      placed_order = place_order_service.call

      render json: placed_order, serializer: OrderSerializer, status: :ok
    end

    private

    def current_cart
      @current_cart ||= cart_service.call
    end

    def cart_service
      CurrentCartService.new(@current_user)
    end

    def add_to_cart_service
      cart = current_cart || create_cart_service.call
      AddToCartService.new(current_cart, params[:product_id], params[:qty])
    end

    def place_order_service
      PlaceOrderService.new(current_cart)
    end

    def create_cart_service
      CreateCartService.new(@current_user)
    end
  end
end
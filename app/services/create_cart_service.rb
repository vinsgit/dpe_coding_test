class CreateCartService
  def initialize(user)
    @user = user
  end

  def call
    create_cart
  end

  private

  def create_cart
    @user.carts.create(status: :ongoing)
  end
end

class CurrentCartService
  def initialize(user)
    @user = user
  end

  def call
    @current_cart ||= ongoing_cart
  end

  private

  def ongoing_cart
    @user.carts.where(status: :ongoing).order('created_at desc').first
  end
end
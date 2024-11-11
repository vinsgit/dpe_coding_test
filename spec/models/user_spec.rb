require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    user = build(:user, username: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a duplicate username' do
    create(:user, username: 'duplicate_user')
    user = build(:user, username: 'duplicate_user')
    expect(user).to_not be_valid
  end

  it 'is not valid with a short password' do
    user = build(:user, password: 'short')
    expect(user).to_not be_valid
  end

  it 'returns true for admin? if username is admin' do
    admin_user = build(:user, :admin)
    expect(admin_user.admin?).to be true
  end

  it 'returns false for admin? if username is not admin' do
    user = build(:user)
    expect(user.admin?).to be false
  end
end

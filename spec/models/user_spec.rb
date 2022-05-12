require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do 
    @user = User.new(
      email: "wilfried.paillot@gmail.com", 
      password: "123456",
      password_confirmation: "123456",
      username: "wilfried",
    )
  end

  context 'validations' do

    it 'is valid with valid attributes' do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe '#username' do
      it "is not valid without a username" do
        @user.username = nil
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it "is not valid with a username shorter than 3 characters" do
        @user.username = 'aa'
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        
      end
      it "is not valid with a username longer than 15 characters" do
        @user.username = 'a' * 16
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it "is not valid with a username containing other than letters, numbers and underscores" do
        @user.username = 'aa@aa'
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe '#email' do
      it "is not valid without an email" do
        @user.email = nil || ''
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it "is not valid with an invalid email" do
        @user.email = 'aa' || 'aa@' || 'aa@aa'
        expect(@user).to_not be_valid
        expect(@user.errors.messages[:email]).to include("is invalid")
      end
      it "is not valid with an email already taken" do
        @user.save!
        @user2 = User.new(
          email: @user.email,
          password: 123456,
          username: "wilfried2",
        )
        expect { @user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it "is valid with a valid email" do
        @user.email = Faker::Internet.email
        expect(@user).to be_valid
      end
    end
    describe '#password' do
      it "is not valid without a password" do
        @user.password = nil || ''
        expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it "is not valid with a password shorter than 6 characters" do
        @user.password = 'a' * 5
        expect(@user).to_not be_valid
        expect(@user.errors.messages[:password]).to include("is too short (minimum is 6 characters)")
      end
      it "is not valid if the password and password confirmation do not match" do
        @user.password_confirmation = 'a' * 6
        expect(@user).to_not be_valid
        expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
      end
      it "is valid with a valid password and password confirmation" do
        @user.password = Faker::Internet.password
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
        expect(@user.password_confirmation).to eq(@user.password)
      end
    end
  end
end

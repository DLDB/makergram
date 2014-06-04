require 'spec_helper'

describe 'orders' do
  let(:post){ create(:post, title: 'Pretty Picture') }
  let(:admin){ create(:admin) }
  let(:user){ create(:user, email: 'customer@foo.com') }

  describe 'orders page' do
 
    context 'logged in as admin' do
      before do
        login_as admin, scope: :admin
      end

      context 'no orders' do

        it 'see a message' do
          visit '/orders'
          expect(page).to have_content 'No orders yet'
        end

      end

    end

    context 'not logged in as admin' do
      it 'prompts me to sign in' do
        visit '/orders'
          expect(page).to have_content 'sign in'
      end
    end

    context 'with orders' do
      before do
        login_as admin, scope: :admin
        christmas_day = Date.new(2013, 12, 25)
        Order.create(id: 1, post: post, user: user, created_at: christmas_day )
        visit '/orders'
      end

      it 'displays the product' do
        expect(page).to have_link 'Pretty Picture'
      end

      it 'displays the customer email' do
        expect(page).to have_content  'customer@foo.com'
      end

      it 'displays the order number' do
        expect(page).to have_content '201312250001'
      end
    end
  end

  describe 'emails' do
    before do
      clear_emails
    end

    it 'sends an email with order number and name of the picture' do
      Order.create(user: user, post: post)
      open_email('customer@foo.com')
      expect(current_email).to have_content 'Thanks for ordering a print of Pretty Picture'
    end
  end

end
require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  let(:valid_csv_file) { fixture_file_upload('files/valid_inventory.csv', 'text/csv') }
  let(:invalid_csv_file) { fixture_file_upload('files/invalid_file.txt', 'text/plain') }
  let(:missing_headers_csv_file) { fixture_file_upload('files/missing_headers_inventory.csv', 'text/csv') }

  describe 'GET #index' do
    it 'returns a success response' do
      create_list(:product, 3)
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    let(:product) { create(:product) }

    it 'returns a success response' do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the product' do
      get :show, params: { id: product.id }
      expect(response.body).to include(product.name)
    end
  end

  describe 'POST #import' do
    context 'with valid CSV file' do
      it 'imports products successfully' do
        post :import, params: { inventory_file: valid_csv_file }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('success')
      end
    end

    context 'with invalid CSV file' do
      it 'returns an error' do
        post :import, params: { inventory_file: invalid_csv_file }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid file type!')
      end
    end

    context 'with missing headers in CSV file' do
      it 'returns an error' do
        post :import, params: { inventory_file: missing_headers_csv_file }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Missing required headers')
      end
    end
  end
end

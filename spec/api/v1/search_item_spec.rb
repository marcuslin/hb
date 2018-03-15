require 'rails_helper'

describe V1::SearchItem do
  let(:key_word) { '雞蛋' }
  let(:results) { crawl_results }

  before do
    allow_any_instance_of(Crawler::Carrefour::Base).to receive(:call)
      .and_return(results)

    allow_any_instance_of(Crawler::RtMart::Base).to receive(:call)
      .and_return(results)
  end

  describe 'GET /api/v1/search' do
    context 'with valid key word' do
      subject { get "/api/v1/search", params: { key_word: key_word } }

      before { subject }

      it 'returns 201' do
        expect(response).to have_http_status 201
      end

      it 'returns search results with key_word as key' do
        expect(json_response).to have_key(key_word.to_sym)
      end

      it 'returns search results with rt_mart_results key' do
        expect(json_response[key_word.to_sym]).to have_key(:rt_mart_results)
      end

      it 'returns search results with carrefour_results key' do
        expect(json_response[key_word.to_sym]).to have_key(:carrefour_results)
      end
    end

    context 'with invalid key word' do
      subject { post "/api/v1/search", params: { key_word: '' } }

      before { subject }

      it 'returns 400' do
        expect(response).to have_http_status 400
      end
    end
  end
end

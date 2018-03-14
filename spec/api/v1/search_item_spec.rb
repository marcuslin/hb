require 'rails_helper'

describe V1::SearchItem do
  context 'POST /api/v1/search' do
    context 'with valid key word' do
      subject { post "/api/v1/search", params: { key_word: 'test' } }
      
      before do
        allow(Crawler::Carrefour::Base.new('test')).to receive(:crawl).and_return({ test: '123' })
        allow(Crawler::RtMart::Base.new('test')).to receive(:crawl).and_return({ test: '123' })
      end

      it 'returns search results' do
        subject
      end
    end
    #
    # context 'with invalid key word' do
    #   subject { post "/api/v1/search", params: { key_word: '' } }
    #
    #   it 'returns search results' do
    #     # expect(subject)
    #     # subject
    #   end
    # end

  end
end

require 'spec_helper'
require 'box'
require 'benchmark'

RSpec.describe Box do
  describe '#fill' do
    let(:width) {10}
    let(:height) {10}
    let(:original_character) {'0'}
    let(:new_character) {'#'}

    context "when fill character is '#'" do
      it "character is now '#'" do
        new_box = Box.new(width, height, original_character).fill(new_character)
        expect(new_box.character).to eq(new_character)
      end
    end
  end

  describe '#expand' do
    let(:width) {10}
    let(:height) {10}
    let(:character) {'0'}
    let(:factor) {2}

    context 'when called with 2' do
      it 'box is now 2 times bigger' do
        new_box = Box.new(width, height, character).expand(factor)
        expect(new_box.width).to eq(width * factor)
        expect(new_box.height).to eq(height * factor)
      end
    end
  end

  describe '#resize' do
    let(:width) {2}
    let(:height) {10}
    let(:character) {'0'}
    let(:new_width) {3}
    let(:new_height) {9}

    context 'when called with 3, 9' do
      it 'dimensions are now 3, 9' do
        new_box = Box.new(width, height, character).resize(new_width, new_height)
        expect(new_box.width).to eq(new_width)
        expect(new_box.height).to eq(new_height)
      end
    end
  end

  describe '#rotate' do
    let(:width) {2}
    let(:height) {10}
    let(:character) {'0'}

    context 'when rotate called' do
      it 'dimensions are flipped' do
        new_box = Box.new(width, height, character).rotate
        expect(new_box.width).to eq(height)
        expect(new_box.height).to eq(width)
      end
    end
  end
end
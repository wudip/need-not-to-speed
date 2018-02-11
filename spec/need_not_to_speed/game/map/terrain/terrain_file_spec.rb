require_relative '../../../../spec_helper'
require 'model/game/map/terrain/terrain_file'

RSpec.describe NeedNotToSpeed::Game::TerrainFile do
  context 'image dimensions' do
    subject(:image) do
      NeedNotToSpeed::Game::TerrainFile.new('spec/resources/terrain_mock.png')
    end

    it 'can read image width' do
      expect(image.width).to eq 3
    end

    it 'can read image height' do
      expect(image.height).to eq 2
    end
  end

  context 'image pixels' do
    subject(:image) do
      NeedNotToSpeed::Game::TerrainFile.new('spec/resources/terrain_mock.png')
    end
    it 'can read red pixel' do
      expect(image.pixel(0, 0)).to eq 255 * 256 * 256
    end

    it 'can read black pixel with alpha' do
      expect(image.pixel(1, 0)).to eq 0
    end

    it 'can read yellow pixel' do
      expect(image.pixel(0, 1)).to eq 255 * 256 * 256 + 255 * 256
    end
  end
end

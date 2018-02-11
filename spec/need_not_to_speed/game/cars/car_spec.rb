require_relative '../../../spec_helper'
require 'model/game/cars/car'

RSpec.describe NeedNotToSpeed::Game::Car do
  context 'changes it\'s state' do
    subject(:car) { NeedNotToSpeed::Game::Car.new(0, 0) }

    it 'doesn\'t turn left until it moves front or back' do
      rotation_start = car.rotation
      car.state.turning_left = true
      rotation_end = car.rotation
      rotation_end += 2 * Math::PI while rotation_end < rotation_start
      expect(rotation_start).to eq rotation_end
    end

    it 'doesn\'t turn right until it moves front or back' do
      rotation_start = car.rotation
      car.state.turning_right = true
      rotation_end = car.rotation
      rotation_end += 2 * Math::PI while rotation_end < rotation_start
      expect(rotation_start).to eq rotation_end
    end
  end
end

require 'spec_helper'
require 'popcorn'
require 'benchmark'

RSpec.describe PopcornSolver do
  describe '#words' do
    let(:letters) { 'PORNPOCC' }
    let(:connections) do
      {
        0 => [1, 2, 3],
        1 => [0, 2, 4, 5],
        2 => [0, 1, 3, 5],
        3 => [0, 2, 5, 6],
        4 => [1, 5, 7],
        5 => [1, 4, 7, 6, 3, 2],
        6 => [3, 5, 7],
        7 => [4, 5, 6]
      }
    end

    it do
      expect(PopcornSolver.new(letters, connections).words).to eq(%w[POP POPCORN CORN])
    end

    context 'when graph is bigger' do
      let(:letter_count) { 12 }
      let(:letters) { Array.new(letter_count) { ('A'..'Z').to_a.sample } }
      let(:connections) do
        letters.size.times.map do |i|
          [i, (0..(letters.size - 1)).to_a.shuffle.sample(rand(letters.size)) ]
        end.to_h
      end

      it 'execution time is low' do
        result_time = Benchmark.realtime do
          PopcornSolver.new(letters, connections).words
        end

        expect(result_time).to be <= 1, 'execution time'
      end
    end
  end
end

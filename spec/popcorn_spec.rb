require 'spec_helper'
require 'popcorn'
require 'benchmark'

RSpec.describe PopcornSolver do
  describe '#words' do

    let(:letter_elements) do
      p1 = Letter.new('P')
      o1 = Letter.new('O')
      r1 = Letter.new('R')
      n1 = Letter.new('N')
      p2 = Letter.new('P')
      o2 = Letter.new('O')
      c1 = Letter.new('C')
      c2 = Letter.new('C')
      p1.neighbours = [o1, r1, n1]
      o1.neighbours = [p1, r1, p2, o2]
      r1.neighbours = [p1, o1, n1, o2]
      n1.neighbours = [p1, r1, o2, c1]
      p2.neighbours = [o1, o2, c2]
      o2.neighbours = [o1, p2, c2, c1, n1, r1]
      c1.neighbours = [n1, o2, c2]
      c2.neighbours = [p2, o2, c1]
      [p1, o1, r1, n1, p2, o2, c1, c2]
    end

    it do
      expect(PopcornSolver.new(letter_elements).words).to eq(%w[POP POPCORN CORN])
    end

    context 'when graph is bigger' do
      let(:letter_elements) do
        p1 = Letter.new('P')
        o1 = Letter.new('O')
        r1 = Letter.new('R')
        n1 = Letter.new('N')
        p2 = Letter.new('P')
        o2 = Letter.new('O')
        c1 = Letter.new('C')
        c2 = Letter.new('C')
        c3 = Letter.new('C')
        n2 = Letter.new('N')
        p3 = Letter.new('P')
        p1.neighbours = [o1, r1, n1, c3, n2]
        o1.neighbours = [p1, r1, p2, o2]
        r1.neighbours = [p1, o1, n1, o2]
        n1.neighbours = [p1, r1, o2, c1]
        p2.neighbours = [o1, o2, c2, p3]
        o2.neighbours = [o1, p2, c2, c1, n1, r1]
        c1.neighbours = [n1, o2, c2]
        c2.neighbours = [p2, o2, c1]

        # letters = 'PORNPOCCCNP'
        # neighbours = ['0' => [1, 2, 3, 8]]
      end

      it 'execution time is low' do
        result_time = Benchmark.realtime do
          PopcornSolver.new(letter_elements).words
        end

        expect(result_time).to be <= 0.05, 'execution time'
      end
    end
  end
end
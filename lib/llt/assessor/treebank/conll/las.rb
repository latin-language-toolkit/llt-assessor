module LLT
  class Assessor::Treebank::Conll
    class Las
      include Score

      def id
        'LAS'
      end

      def score_location
        :relations
      end
    end
  end
end


module LLT
  class Assessor::Treebank::Conll
    class Uas
      include Score

      def id
        'UAS'
      end

      def score_location
        :heads
      end
    end
  end
end

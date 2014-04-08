module LLT
  class Assessor::Treebank::Conll
    class La
      include Score

      def id
        'LA'
      end

      def assess(diff)
        total    = diff.report[:words].total
        wrong_la = count_of_wrong_head_or_relation(diff.all_differences)
        @score = percentage_of(total - wrong_la, total)
      end

      def count_of_wrong_head_or_relation(differences)
        differences.count { |difference| difference[:head] || difference[:relation] }
      end
    end
  end
end

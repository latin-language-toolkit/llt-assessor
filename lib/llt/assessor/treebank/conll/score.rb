module LLT
  class Assessor::Treebank::Conll
    module Score
      include Core::Structures::HashContainable

      # use another module to handle the description part

      attr_reader :score

      def initialize
        super(id)
      end

      def description
      end

      def assess(diff)
        stats = diff.report[score_location]
        @score = percentage_of(stats.right, stats.total)
      end

      def id
        # implemented by including clases
      end

      def score_location
        # implemented by including classes
      end

      def xml_tag
        @id
      end

      def xml_attributes
        { score: @score }
      end

      private

      def percentage_of(part, total)
        (part.to_f / total * 100).round(2)
      end
    end
  end
end


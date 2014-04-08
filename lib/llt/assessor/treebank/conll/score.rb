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
        @score = (stats.right.to_f / stats.total * 100).round(2)
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
    end
  end
end


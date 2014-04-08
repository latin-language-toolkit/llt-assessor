module LLT
  class Assessor::Treebank::Conll
    class Las
      include Core::Structures::HashContainable

      # use a module to handle the description part

      attr_reader :score

      def initialize
        super('LAS')
      end

      def description
      end

      def assess(diff)
        stats = diff.report[:relations]
        @score = (stats.right.to_f / stats.total * 100).round(2)
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


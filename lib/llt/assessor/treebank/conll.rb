module LLT
  class Assessor::Treebank
    class Conll < Assessor::Treebank
      require 'llt/assessor/treebank/conll/score'
      require 'llt/assessor/treebank/conll/las'
      require 'llt/assessor/treebank/conll/uas'

      def initialize(diff)
        super(diff, :conll)
      end

      def assess
        compute_metrics
        self
      end

      def xml_tag
        @id
      end

      def xml_attributes
        {}
      end

      private

      METRICS = %i{ las uas }
      def compute_metrics
        METRICS.each do |metric|
          new_metric = self.class.const_get(metric.to_s.capitalize).new
          new_metric.assess(@diff)
          add(new_metric)
        end
      end
    end
  end
end



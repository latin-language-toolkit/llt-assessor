module LLT
  module Assessor
    class Treebank
      autoload :Conll, 'llt/assessor/treebank/conll'

      include Core::Structures::HashContainable

      attr_reader :diff

      container_alias :metrics

      def initialize(diff, id = 'treebank-assessment')
        @diff = diff
        super(id)
      end

      def assess(*metrics)
        metrics.each do |metric|
          new_metric = metric_class(metric).new(@diff)
          new_metric.assess
          add(new_metric)
        end
      end

      private

      # need to catch invalid requests at some point
      def metric_class(metric)
        self.class.const_get(metric.to_s.capitalize)
      end
    end
  end
end

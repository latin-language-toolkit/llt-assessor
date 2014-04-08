require 'spec_helper'

describe LLT::Assessor::Treebank do
  let(:g1) do
    <<-eof
      <treebank>
        <sentence id="21" document_id="perseus:text:1999.02.0002" subdoc="book=2:chapter=5" span="in3:erat0">
          <word id="1" form="in" lemma="in1" postag="r--------" head="5" relation="auxp"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="atr"/>
          <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="adv"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="sbj"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="pred"/>
        </sentence>
      </treebank>
    eof
  end

  let(:r1) do
    <<-eof
      <treebank>
        <sentence id="21" document_id="perseus:text:1999.02.0002" subdoc="book=2:chapter=5" span="in3:erat0">
          <word id="1" form="in" lemma="in1" postag="r--------" head="4" relation="auxp"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nd-" head="3" relation="atr"/>
          <word id="3" form="flumine" lemma="flumen2" postag="n-s---nd-" head="1" relation="adv"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="obj"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="pred"/>
        </sentence>
      </treebank>
    eof
  end

  let(:differ) { LLT::Review::Treebank.new }

  let(:diff) do
    allow(differ).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
    allow(differ).to receive(:get_from_uri).with(:uri_for_r1) { r1 }
    result = differ.diff([:uri_for_g1], [:uri_for_r1])
    result.first
  end

  describe "#initialize" do
    it "has to be initialized with a diff, i.e. an instance of LLT::Review::Treebank::Comparison" do
      # this should be static later on
      assessor = LLT::Assessor::Treebank.new(diff)
      assessor.diff.should_not be_nil
    end
  end

  describe "#assess" do
    it "takes on or several metrics and adds the results of these to its container" do
      assessor = LLT::Assessor::Treebank.new(diff)
      assessor.assess(:conll)
      assessor.metrics.should have(1).item
      assessor.container.should == assessor.metrics
      assessor[:conll].should_not be_nil
    end
  end
end

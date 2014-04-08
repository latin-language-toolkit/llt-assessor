require 'spec_helper'

describe LLT::Assessor::Treebank::Conll do
  let(:g1) do
    <<-EOF
      <treebank>
        <sentence id="21" document_id="perseus:text:1999.02.0002" subdoc="book=2:chapter=5" span="in3:erat0">
          <word id="1" form="in" lemma="in1" postag="r--------" head="5" relation="ADV"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nb-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen1" postag="n-s---nb-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="SBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
      </treebank>
    EOF
  end

  let(:r1) do
    <<-EOF
      <treebank>
        <sentence id="21" document_id="perseus:text:1999.02.0002" subdoc="book=2:chapter=5" span="in3:erat0">
          <word id="1" form="in" lemma="in1" postag="r--------" head="4" relation="AuxP"/>
          <word id="2" form="eo" lemma="is1" postag="p-s---nd-" head="3" relation="ATR"/>
          <word id="3" form="flumine" lemma="flumen2" postag="n-s---nd-" head="1" relation="ADV"/>
          <word id="4" form="pons" lemma="pons1" postag="n-s---mn-" head="5" relation="OBJ"/>
          <word id="5" form="erat" lemma="sum1" postag="v3siia---" head="0" relation="PRED"/>
        </sentence>
      </treebank>
    EOF
  end

  let(:differ) { LLT::Review::Treebank.new }

  let(:diff) do
    allow(differ).to receive(:get_from_uri).with(:uri_for_g1) { g1 }
    allow(differ).to receive(:get_from_uri).with(:uri_for_r1) { r1 }
    result = differ.diff([:uri_for_g1], [:uri_for_r1])
    result.first
  end

  let(:conll) { LLT::Assessor::Treebank::Conll.new(diff) }

  describe "#initialize" do
    it "also takes a diff as starting point" do
      conll.diff.should_not be_nil
    end
  end

  describe "#assess" do
    it "should return itself, containing scores in its container" do
      conll.assess.should == conll
      conll.should_not be_empty
      conll['LAS'].score.should == 60.0
      conll['UAS'].score.should == 80.0
      conll['LA'].score. should == 60.0
    end
  end
end

require 'sinatra/base'
require 'sinatra/respond_with'
require 'llt/assessor'
require 'llt/review'

class Api < Sinatra::Base
  register Sinatra::RespondWith

  get '/:type/assess' do
    gold = Array(params[:gold])
    rev  = Array(params[:reviewable])
    metrics = Array(params[:metrics])

    klass = params[:type]
    # return an error if klass is neither treebank nor Alignment

    diff = LLT::Review.const_get(klass.capitalize).new
    diff.diff(gold, rev)

    # Call Assessor here, a little unsure how this is done best right now.
    # We could be happy with it and just return the diff output, which will
    # contain the assessments as well - however this is not really flexible,
    # and we wouldn't be able to return such an output for files that were
    # not constructed by llt-review (which might never happen though!)
    #
    # For now we live with the limited flexibility
    diff.diffs.each do |comparison|
      assessor = LLT::Assessor.const_get(klass.capitalize).new(comparison)
      assessor.assess(*metrics)
    end

    respond_to do |f|
      f.xml { diff.to_xml }
    end
  end
end

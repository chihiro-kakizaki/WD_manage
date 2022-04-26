class AssignsController < ApplicationController

  def create
    approval = Approval.find_by(pair_id: params[:pair_id])
    Assign.create(pair_id: approval.pair_id, user_id: approval.user_id)
    redirect_to  pair_path(approval.pair)
  end
end

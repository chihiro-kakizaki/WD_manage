class ApprovalsController < ApplicationController

  def destroy
    approval = Approval.find(params[:id])
    approval.destroy
    redirect_to  posts_path
  end
end

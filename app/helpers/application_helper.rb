module ApplicationHelper
  
  def create_pair
    if current_user.assign.present?
      @pair = current_user.assign.pair.id
    end
  end
end

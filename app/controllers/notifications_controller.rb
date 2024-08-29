class NotificationsController < ApplicationController
  def count
    render json: { count: current_user.notification_count }
  end
end

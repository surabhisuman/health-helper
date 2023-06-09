module NotificationHelper

  class << self

    def send_notification(requester_id, customer_id, context, consultation_id, type)
      existing_notification = Notification.find_by(sender: requester_id, person_id: customer_id, title: context, consultation_id: consultation_id, notification_type: type)
      return if existing_notification
      data = context + " from " + requester_id
      Notification.create(title: context, data: data, person_id: customer_id, sender: requester_id, consultation_id: consultation_id, notification_type: type)
    end
  end
end
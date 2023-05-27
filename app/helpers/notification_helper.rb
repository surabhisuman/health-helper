module NotificationHelper

  class << self

    def send_notification(requester_id, customer_id, context)
      existing_notification = Notification.find_by(sender: requester_id, person_id: customer_id, title: context)
      return if existing_notification
      data = context + " from " + requester_id
      notification = Notification.create(title: context, data: data, person_id: customer_id, sender: requester_id)
      # send notification
      # todo: figure out how to send
    end
  end
end
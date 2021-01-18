module MessagesHelper
  MESSAGES = {
    update: "OK, we got your changes"
  }.freeze

  def show_message_after(type)
    MESSAGES[type]
  end
end

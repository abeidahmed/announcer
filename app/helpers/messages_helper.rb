module MessagesHelper
  MESSAGES = {
    update: "OK, we got your changes"
  }

  def show_message_after(type)
    MESSAGES[type]
  end
end

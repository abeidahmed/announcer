module FlashHelper
  TOAST_PROPERTIES = {
    success: { icon: "check-circle-fill" },
    alert: { icon: "x-circle-fill" }
  }.freeze

  def flash_icon_for(type)
    raise "Undefined flash type" if toast_type(type).nil?

    toast_type(type)[:icon]
  end

  private

  def toast_type(type)
    TOAST_PROPERTIES[type.to_sym]
  end
end

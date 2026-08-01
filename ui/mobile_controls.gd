extends Control

func _ready():
	if is_running_on_mobile():
		show_mobile_controls()
	else:
		hide_mobile_controls()


func is_running_on_mobile() -> bool:
	if OS.has_feature("mobile"):
		return true

	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		return true

	return false


func show_mobile_controls():
	self.visible = true


func hide_mobile_controls():
	self.visible = false

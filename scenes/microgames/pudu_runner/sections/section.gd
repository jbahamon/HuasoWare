extends Node2D

signal visible
signal entered_area

func get_connector_position():
	return $EndConnector.global_position


func _on_VisibilityNotifier2D_screen_entered():
	emit_signal("visible")


func _on_Area2D_body_entered(body):
	emit_signal("entered_area", self, body)

func get_bottom_bounds():
	return 240

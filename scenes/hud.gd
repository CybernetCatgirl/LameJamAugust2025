extends CanvasLayer

class_name HUD

var max_depth = 0

func update_oxygen(remaining):
	$OxygenCount.text = ("Oxygen: " + str(remaining) + "%")

func update_depth(depth):
	$DepthMeter.text = ("Current Depth: " + str(depth) + "m")
	if depth > max_depth:
		max_depth = depth
		$MaxDepthMeter.text = ("Maximum Depth: " + str(depth) + "m")

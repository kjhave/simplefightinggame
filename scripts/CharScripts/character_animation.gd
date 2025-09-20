extends AnimationTree

@onready var player: Player = get_owner()
@onready var state_machine: AnimationNodeStateMachinePlayback = self.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_state = state_machine.get_current_node()
	
	if current_state != "" && self.tree_root.get_node(current_state) is AnimationNodeBlendSpace2D:
		self.set("parameters/%s/blend_position" % current_state, player.face_direction)

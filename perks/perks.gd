@tool
extends Area2D

@export var upgrade_label : Label
@export var sprite : Sprite2D
#@export var bullet_strategy : BaseBulletStrategy:
#	set(val):
#		bullet_strategy = val
#		needs_update = true
@export var player_strategy : BasePlayerUpgrade:
	set(val):
		player_strategy = val
		needs_update = true

# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update := false


func _ready() -> void:
	body_entered.connect(on_body_entered)
	#sprite.texture = player_strategy.texture
#	upgrade_label.text = player_strategy.upgrade_text



func _process(delta: float) -> void:
	
	# This is run only when we're editing the scene
	# It updates the texture of the sprite when we replace the upgrade strategy
	if Engine.is_editor_hint():
		if needs_update:
			sprite.texture = player_strategy.texture
			upgrade_label.text = player_strategy.upgrade_text
			needs_update = false


func on_body_entered(body: PhysicsBody2D):
	if body.get_parent() is Player:
		######################################
		# Strategy Relevant Code:
		# This adds the upgrade to our player,
		######################################
		body.get_parent().upgrades.append(player_strategy)
		
		queue_free()

class_name DashUpgrade
extends BasePlayerUpgrade

func apply_upgrade(player:Player):
	player.swimming_amp *= player.swiming_amp *1.2
	

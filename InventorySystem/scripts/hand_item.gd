## A simple bluprint class to define Items which can be interacted with while holding them.
## Interactable Item scenes can inherit from that script. (Part of the Inventory System)

extends Node
class_name HandItem


func on_use():
	print("Item gets used.")
	

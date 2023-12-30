extends Node2D

signal toBeadBoxCamera
signal toBookCamera

var nightImg = preload("res://Assets/Main Scene/mainscene_bottom_dark.png")

var pause = true
@onready var client = $Sprites/Zeke
@onready var db = [$DialogueBox, $DialogueBox2] #dialogue box
var db_idx = 2

var box1 = preload("res://Scenes/Objects/dialogue_box.tscn")
var box2 = preload("res://Scenes/Objects/dialogue_box2.tscn")
var box = null

var inTutorial = true
var tutorialSection = 1
var tutorialIdx = 0
var tutorial = [
	["What great weather today!", 1],
	["This is the first time I’ve operated the caravan on my own.", 1],
	["It’s a bit nerve wracking, but I’m excited to sell charms by myself.", 1],
	["It was sad to leave my mentor’s side as an apprentice, but I’m all grown up now.", 1],
	["I’m sure I can handle all of this on my own!", 1],
	["Hm... maybe I can start by making a charm for myself.", 1],
	["A little something to make sure it’ll be a great day ahead!", 1],
	["First of all... let me open my beads drawer...", 1],
	[null, 2]
#[PLAYER TO CLICK THE DRAWER]
#[PULL HELP SCREEN UP. FORCED TUTORIAL TIME]
	]

var x = 1
var level = 0
var dialogues = [
	# level 0 - zeke
	["Woah!", 1], 
	["Hello. I heard that there was a caravan in town specialising in charms.", 0], 
	["Is this the correct place?.", 0], 
	["Yes! I do make charms.", 1], 
	["How may I help you today?", 1], 
	["Oh, that’s great.", 0], 
	["It’s a bit embarrassing to admit, but...", 0], 
	["I would like a charm for money.", 0], 
	["Money!?!", 1], 
	["Money.", 0], 
	["... (then maybe you should go to the bank?)", 1], 
	["(coughs)", 0], 
	["You see, I’ve been robbed.", 0], 
	["My dukedom has flourished ever since my rule, and we’re known for having great reserves.", 0], 
	["It would seem that someone has gotten immensely desperate and abducted all of it.", 0], 
	["ALL of it!?!", 1], 
	["(Maybe there wasn’t a lot in the reserves after all?)", 1], 
	["Yes, everything in my vault is missing.", 0], 
	["Mind you, it’s the size of a large barn.", 0], 
	["No evidence of how it vanished, either.", 0], 
	["The lock is still intact and all my guards are alive.", 0], 
	["WOAH... that’s crazy...", 1], 
	["I know...", 0], 
	["That’s very unfortunate...", 1],
	["I know.......", 0], 
	[".............", 1],
	["...............", 0],  
	[".................", 1], 
	["So? You think you can help me with a little charm or something?", 0], 
	["Truth to be told, I’m in the talks of marriage with the daughter of a neighbouring county.", 0], 
	["And I know for a fact that my wealth is the most charistmatic thing about me.", 0], 
	["Not saying that I’m lacking in other aspects, of course.", 0], 
	["But I have yet to meet anyone who one can resist the sheen of gold when it flashes in front of their eyes.", 0], 
	["I am genuinely in love with the lady, so...", 0], 
	["It’ll be rather devastating if they no longer want to proceed because of this.", 0], 
	["Please say you can help. I’m out of options.", 0], 
	["O-of course I can help!", 1], 
	["Uhm, I’ll try my best, I mean.", 1], 
	["I’ll have to look through my reference books but there should be something for your situation.", 1], 
	["Just give me a moment and I’ll get you a charm all set up!", 1], 
	[null, 2],
	
	# level 1 - ray
	["Greetings. Quite the happy customer you’ve just entertained, I see.", 0],
	["Oh! Hello, welcome!", 1],
	["Nice to meet you. A little bird told me that a charm maker is in town.", 0],
	["Would you happen to be the one it sings about?", 0],
	["I guess... I don’t know if other charm makers who are around here.", 1],
	["How may I help you today?", 1],
	["That’s great! You’re a lifesaver.", 0],
	["You see, I’ve been in search of some... inspiration. ", 0],
	["For my new book.", 0],
	["The problem is, my inspiration keeps running away from me.", 0],
	["My latest novel is a heart wrenching love story between a human and a monster.", 0],
	["As you might have heard, there’s been sightings of an Eldritch being around here.", 0],
	["I was hoping that I’ll be able to attract it somehow, so I can learn more about it.", 0],
	["After all, fiction is based on reality - I can’t just write without any basis.", 0],
	["I need something solid, tangible, and concrete.", 0],
	["... (He wants to meet the Eldritch being!?! Isn’t that dangerous!?!)", 1],
	["... (Wait. But if he succeeds in attracting it, that means the monster will never visit me!)", 1],
	["...! (Sounds like a win for both of us!)", 1],
	["Sure! I’ll try my best to work something out for you.", 1],
	["Can I ask for more details about the Eldritch being you’re looking for?", 1],
	["Well, honestly… I don’t know much about it either.", 0],
	["But one thing’s for sure - I know it’ll be the most beautiful and fascinating creature I’ll ever meet.", 0],
	["Best case scenario, I want a charm that can attract hot single Eldritch beings in the area.", 0],
	["But if it doesn’t work out, I’d like it if I could at least repel regular, normal civilians.", 0],
	["Sometimes, weirdos make good inspiration, too.", 0],
	["Ok, got it! Please give me a moment.", 1],
	["No worries. Take your time.", 0],
	["(The client’s desired effect is to attract oddities and repel normality.)", 1],
	["(In this case, an asymmetrical charm would bring out the best effect.)", 1],
	[null, 2],
	
	#level 2 - eld
	["...", 0], 
	[".....?", 1],
	["........", 0], 
	[".....", 1],
	["Can I help you?", 1], 
	["!!", 0],
	["Um...", 0], 
	["You make charms?", 0],
	["Why, yes. Yes, I do make charms.", 1], 
	["Are you a specialist? Or can you make all types of charms?", 0],
	["If I have the beads for what you 're looking for...", 1], 
	["Charm to stay hidden?", 0],
	["Um...yes? Hidden from what?", 1], 
	["Man.", 0],
	["Man?", 1], 
	["Man, maybe more, I don't know. Maybe all of them. No questions.", 0],
	["Charm to stay hidden, out of memory.", 0],
	["(How suspicious.)", 1], 
	["May I ask what for?.", 1], 
	["No.", 0],
	["I...I don't want to answer.", 0],
	["How can I make the charm you want if I don't know the details?.", 1],
	["I will cry.", 0],
	["...will you?", 1],
	["If you insist on asking, I might.", 0],
	["With all due respect, I can barely see your eyes from under that hat.", 1],
	["Or anything else, why are you wearing a scarf anyways? It's still warm..", 1],
	["I like this scarf, it's a fashion statement, or something along those lines.", 0], 
	["You don't need to know the details, just know I want to stay out of people's minds.", 0],
	["Alright?", 1],  
	["Oh, uh...", 0],
	["It'd also be great if you can also make the charm repel bad futures.", 0],
	["Can't hurt to have that, too, right?", 0],
	["Of course. Anything else?", 1], 
	["Can you please hurry, I'm afraid they'll catch up to me soon.", 0],
	["(Can't be helped. This is my job.)", 2],  
	[null, 2],
	
	#ending
	["...", 1], 
	["It's getting late.", 1], 
	["There doesn't seem to be anymore clients for the day", 1], 
	["It's already dark outside, time to close up shop.", 1], 
	["Whew! I'm glad my first day went alright!", 1],
	["Hopefully tomorrow will be just as good!", 1], 
	]
	
var inThanks = false
var thanks = [
	#level 0 - zeke
	["Here you go!", 1],
	["Wow! Thank you.", 0],
	["I’ll make sure to wear this wherever I go.", 0],
	["You’re welcome!!", 1],
	["Oh, and no worries about the payment. It’s on the house... or on the caravan?", 1],
	["I hope you can get your money back soon...", 1],
	["I hope so too...", 0],
	["It’s still strange though, how all the gold vanished without a trace...", 0],
	["Speaking of which, you might want to look out for yourself.", 0],
	["There’s been the talk of Eldritch beings roaming around the area.", 0],
	["I imagine it’ll be particularly dangerous for someone like you who lives alone, in a caravan to count.", 0],
	["Is that so? Thank you for the heads up, I’ll keep an eye out!", 0],
	["Take care, little charm artisan. Thanks for your help!", 1],
	[null, 2],
	
	# level 1 - ray
	["Here you go!", 1],
	["Oh? This is quite the item.", 0],
	["Thank you, it’s very pretty.", 0],
	["I hope your skillful artisanship will be able attract Eldritch beings with its charm.", 0],
	["I... I hope so too!", 1],
	["Best of luck on your, uhm, date. Haha.", 1],
	["Thanks! I’ll need it.", 0],
	["As for the payment...", 0],
	["Oh no, no, no! You’re doing me a favour, honestly.", 1],
	["Please take it for free.", 1],
	["(And make sure the thing stays away from me!)", 1],
	["I’d feel bad...", 0],
	["How about this? I’ll give you a free signed copy of my book when it comes out.", 0],
	["Given that I survive the encounter, of course!", 0],
	["Oh! Sure! Hahaha...", 1],
	["(He better not come back with the monster, though! I wouldn’t want to meet one!)", 1],
	["I’ll take my leave, then.", 0],
	["Thanks for the impeccable service!", 0],
	["You’re very much welcome!!!", 1],
	[null, 2],

	
	# level 2 - eld
	["It's done, here you go.", 1], 
	["This is it...!", 0], 
	["Thank you, with this, I might be able to stay safe from those guys.", 0],
	["Which guys are you talking about?", 1],
	["Are you wanted?", 1], 
	["Aha, wanted by many, yes.", 0],
	["(Was that a wink? I can't tell.)", 1],
	["Thank you so much, here, for payment I'll give you two full bags of gold!", 0],   
	["And this flower I found on the side of the road.", 0],  
	["Ta-ta!.", 0],   
	["(They're gone before I could even reply...)", 1],  
	["(What a weirdo.)", 1],  
	["(I got paid pretty handsomely for all of that.)", 1],  
	["I guess today wasn't so bad after all!", 1], 
	[null, 2]
	]
	
var idx = 0
var thanksIdx = 0

var answers = ["heeeh", "ifbeg", "afbfj jfbfa"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#runTutorial()
	#startGame()
	

var cameraPos = 1

func _input(event):
	if event.is_action_pressed("Up"):
		x += 1
		print(x)
	
	if !pause:
		
		if event.is_action_pressed("Right") and cameraPos < 2:
			print(cameraPos)
			match cameraPos:
				0:
					$AnimationPlayer.play("leftToMid")
					$Camera2D/LButt.visible = true
				1:
					$AnimationPlayer.play("cameraToRight")
					$Camera2D/rbutt.visible = false
			
			cameraPos += 1
		
		if event.is_action_pressed("Left") and cameraPos > 0:
			print(cameraPos)
			match cameraPos:
				1:
					$AnimationPlayer.play("cameraToLeft")
					$Camera2D/LButt.visible = false
				2: 
					$AnimationPlayer.play("rightToMid")
					$Camera2D/rbutt.visible = true
			
			cameraPos -= 1
					
	#if event.is_action_pressed("Down"):
		#dialRun()
	
	if event.is_action_pressed("leftMouseClick") and box != null and box.hover:
		if inTutorial:
			runTutorial()
		elif inThanks:
			TYDialRun()
		else:
			idx += 1
			dialRun()
		
		#if db_idx < 2 and db[db_idx].finish and db[db_idx].hover:
			#idx += 1
			#db[db_idx].visible = false
			#db[db_idx].finish = false
			#dialRun()

# trigger to start game
func startGame():
	$TutorialPointer.queue_free()
	inTutorial = false
	$Sprites/Zeke.visible = true
	dialRun()
	

# scene change clickables 
func _on_drawer_input_event(_viewport, event, _shape_idx):
	if $Interactables/Drawer.hover and event.is_action_pressed("leftMouseClick"):
		toBeadBoxScene()

func _on_drawer_door_input_event(_viewport, event, _shape_idx):
	if $Interactables/DrawerDoor.hover and event.is_action_pressed("leftMouseClick"):
		toBeadBoxScene()

func _on_books_input_event(_viewport, event, _shape_idx):
	if $Interactables/Books.hover and event.is_action_pressed("leftMouseClick"):
		toBookScene()
		

func toBeadBoxScene():
	if !pause:
		toBeadBoxCamera.emit(answers[level], inTutorial)

func toBookScene():
	if !pause:
		toBookCamera.emit(0)

#play tutorial
func runTutorial():
	#print("run Tutor")
	if tutorialIdx < len(tutorial):
		yeetBox()
		
		var lineArr = tutorial[tutorialIdx]
		var i = lineArr[1] # box index
		var line = lineArr[0] # text
		match i:
			0: 
				box = box1.instantiate()
				
			1: 
				box = box2.instantiate()
	
			2: 
				pause = false
				$TutorialPointer.visible = true
				runTutorialSections()
		
		# if box is not null
		if box != null:
			add_child(box)
			box.position = db[i].position
			box.loadDialogue(line, false)
		
		tutorialIdx += 1
	else:
		inTutorial = false
		
			
	
func runTutorialSections():
	match tutorialSection:
		1: 
			$UI.helpButtonOpen(true)
			tutorialSection += 1

# play dialogues
func dialRun():
	yeetBox()
	if idx >= len(dialogues):
		$AnimationPlayer.play("ending")
	elif idx < len(dialogues) and dialogues[idx][1] < 2:
		#print("in")
		pause = true
		db_idx = dialogues[idx][1]
		
		if db_idx == 0:
			box = box1.instantiate()
		else:
			box = box2.instantiate()
		add_child(box)
		box.position = db[db_idx].position
			
		#db[db_idx].visible = true
		box.loadDialogue(dialogues[idx][0], false)
	else:
		db_idx = 2
		pause = false
	
	if pause:
		$Camera2D/rbutt.visible = false
		$Camera2D/LButt.visible = false
	else:
		$Camera2D/rbutt.visible = true
		$Camera2D/LButt.visible = true

func TYDialRun():
	yeetBox()
	
	if thanksIdx < len(thanks) and thanks[thanksIdx][1] < 2:
		pause = true
		db_idx = thanks[thanksIdx][1]
		
		if db_idx == 0:
			box = box1.instantiate()
		else:
			box = box2.instantiate()
		add_child(box)
		box.position = db[db_idx].position
		
		box.loadDialogue(thanks[thanksIdx][0], false)
		thanksIdx += 1
	else:
		pause = false
		inThanks = false
		thanksIdx += 1
		level += 1
		$AnimationPlayer.play("next_transition")
	
		
func runNext():
	client.visible = false
	match level:
		0:
			client.visible = true
		1: 
			client = $Sprites/Ray
			client.visible = true
		2:
			client = $Sprites/Eld
			client.visible = true
			
	# Enter ending scene
	if thanksIdx >= len(thanks):
		print(idx)
		$BGBottom.texture = nightImg
		idx += 1
	

func startNext():
	#print("startNext")
	idx += 1
	dialRun()
	
func toEnding():
	get_tree().change_scene_to_file("res://Scenes/ending_scene.tscn")

func yeetBox():
	if box:
		box.queue_free()
		box = null


func _on_rbutt_input_event(_viewport, event, _shape_idx):
	if !pause and $Camera2D/rbutt.hover and event.is_action_pressed("leftMouseClick") and cameraPos < 2:
			match cameraPos:
				0:
					$AnimationPlayer.play("leftToMid")
					$Camera2D/LButt.visible = true
				1:
					$AnimationPlayer.play("cameraToRight")
					$Camera2D/rbutt.visible = false
			
			cameraPos += 1
		


func _on_l_butt_input_event(_viewport, event, _shape_idx):
	if !pause and $Camera2D/LButt.hover and event.is_action_pressed("leftMouseClick") and cameraPos > 0:
			print(cameraPos)
			match cameraPos:
				1:
					$AnimationPlayer.play("cameraToLeft")
					$Camera2D/LButt.visible = false
				2: 
					$AnimationPlayer.play("rightToMid")
					$Camera2D/rbutt.visible = true
					
			
			cameraPos -= 1

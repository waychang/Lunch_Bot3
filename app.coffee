Framer.Extras.Hints.disable()
# Screen.backgroundColor = "fafafa"

Framer.Defaults.animationOptions = 
	curve: "ease"
	time: 0.3

Screen.z = -1000

cwTeXYen = Utils.loadWebFont("fonts：cwTeXYen")

Framer.Defaults.Layer.style = 
	fontFamily: "#{cwTeXYen}, Arial"


bg = new BackgroundLayer
# 	backgroundColor: "white"
	scale: 2
	z: -200
# 	style: 
# 		"background": "linear-gradient( hsl(0,0%,50%) 0%, hsl(0,0%,50%) 100%)"
	

bg.gradient =
	start: "hsl(300,5%,80%)"
	end: "hsl(240,5%,60%)"
	angle: 80

# =========================== 

bouncing_ani = (card) ->
	ori_opacity = card.scale
	bouncing_ani_a = new Animation
		layer: card
		properties:
			opacity: ori_opacity * 0.5
# 			brightness: 110
		curve: "spring(400,20,0)"
		time: 0.1

	bouncing_ani_b = new Animation
		layer: card
		properties:
			opacity: ori_opacity
# 			brightness: 100
		curve: "spring(400,20,0)"
		time: 0.1
	
	bouncing_ani_a.start()
	Utils.delay 0.1, ->
		bouncing_ani_b.start()


press_effect = (btn) ->
	btn_press = 0
	btn.onTouchStart ->
		@.animate (brightness: 90, scale: 0.9)
		btn_press = 1

	btn.onTouchMove ->
		@.animate (brightness: 100, scale: 1)
		btn_press = 0

	btn.onTouchEnd ->
		@.animate (brightness: 100, scale: 1)
		if btn_press is 1
			btn_press = 0
	
	btn.states.animationOptions =
		time: 0.3
		curve: "spring(400,20,0)"


# =========================== 


copyToClipboard = (str) ->
	el = document.createElement('textarea')
	el.value = str
	el.setAttribute 'readonly', ''
	el.style.position = 'absolute'
	el.style.left = '-9999px'
	document.body.appendChild el
	selected = if document.getSelection().rangeCount > 0 then document.getSelection().getRangeAt(0) else false
	el.select()
	document.execCommand 'copy'
	document.body.removeChild el
	if selected
		document.getSelection().removeAllRanges()
		document.getSelection().addRange selected
	return


# =========================== 
	
	
# lunch_1 = [
# 	"Laji（長鴻小館）🍣"
# 	"怪味雞 - Weird Chicken 🐔"
# 	"饌味鮮 (Prada’s dumplings) 🥟"
# 	"579 beef noodle 🐂"
# 	"茶水攤 HK place 🥘🇭🇰"
# 	"小班 Soban 🥘🇰🇷"
# 	"北投魷魚 🦑"
# 	"Dica 狄卡 🐖"
# 	"瘦虎麵屋 🐯"
# 	"Tokyo Curry 東京咖哩 🍛🇯🇵"
# ]
# 
# lunch_2 = [
# 	"I’m pasta 🇮🇹🍝"
# 	"紅燈榮 🍜"
# 	"不一樣乾麵 🍜"
# 	"Sukiya 🍛🇯🇵"
# 	"Pho 🍜🇻🇳"
# 	"麻膳堂 🍜"
# 	"McDonald 麥當勞 🍔🍟"
# 	"鐵人九番 🥘"
# 	"林記麻醬麵 🍜"
# 	"Hala Chicken "
# 	"阿明炒鱔魚 🐊"
# 	"老鄧"
# 	"口杯食堂 (Thai Rice) 🍚🥡"
# ]
# 
# # Vege Restaurants
# lunch_3 = [
# 	"誠食健康素食 🥬"
# 	"Loving Hut (Vegan) 🥗"
# 	"綠也素食 🥒"
# 	"蔬河 Vege Creek 🥦"
# ]

lunch_1 = [
	"Japannese 🍣"
	"Chicken 🐔"
	"Dumplings 🥟"
	"Beef noodle 🐂"
	"HongKong 🥘🇭🇰"
	"Thai Food 🍚🇹🇭"
	"Pho 🍜🇻🇳"
	"Krean 🥘🇰🇷"
	"Pork 🐖"
	"Noodle 🍜"
	"Curry 🍛"
	"Taiwan Food 🍜"
]

lunch_2 = [
	"Pasta 🇮🇹🍝"
	"Japannese 🍛🇯🇵"
	"Spicy Noodle 🍜🌶"
	"McDonald 🍔🍟"
]

# Vege Restaurants
lunch_3 = [
	"Vegan 🥬"
	"Vegetarian 🥗🥚🥛"
	"Pescetarian 🥒🐟"
	"Freegan 🥦🥩"
	"Flexitarian 🥗🥓"
]

# lunch_grp_1 = []
# lunch_grp_2 = []
# lunch_grp_3 = []

lunch_grp_1 = lunch_1
lunch_grp_2 = lunch_2
lunch_grp_3 = lunch_3

isUpdated = false

updateData = (isUpdated_2=isUpdated) ->
	# Check internet
	ifConnected = window.navigator.onLine
# 	print isUpdated
# 	print ifConnected
	ifConnected = false
	if ifConnected and isUpdated_2 is false
# 		print "Hi"
		# Google spreadsheet settings
		# https://docs.google.com/spreadsheets/d/1qrHaRFYi2P2L0QHbieu0m_IUHcx_1XodozHi1FIrUT0/edit?usp=sharing
		spreadsheet_id = "1qrHaRFYi2P2L0QHbieu0m_IUHcx_1XodozHi1FIrUT0"
		# od6 - ignore sheet number
		json_url = "https://spreadsheets.google.com/feeds/list/"+spreadsheet_id+"/od6/public/values?alt=json"
		data = JSON.parse Utils.domLoadDataSync json_url
		
		# Load data one time
		isUpdated = true

		# data
		g_count = data.feed.entry.length
		
		g_name_array = []
		lunch_grp_1 = []
		lunch_grp_2 = []
		lunch_grp_3 = []
	
		for i in [0...g_count]
			g_name = data.feed.entry[i]["gsx$name"]["$t"]
			g_group = data.feed.entry[i]["gsx$group"]["$t"]
			
			g_name_array.push({name: g_name, group: g_group})
			
			lunch_grp_1.push(g_name) if g_group is "1"
			lunch_grp_2.push(g_name) if g_group is "2" or g_group is "3"
			lunch_grp_3.push(g_name) if g_group is "4"

		random_lunch()
# 		print 1
	else
		random_lunch()
# 		print lunch_grp_1[0]
		



# =================================



random_text_num = 4
random_text_h = 60
card_margin = 20
card_h = card_margin * 2 + random_text_h * random_text_num
card_w = 280
card = new Layer	
# 	width: Screen.width * 0.8
	width: card_w
	height: card_h
	x: Align.center
	y: 120 + 60
	borderRadius: 10
	borderColor: "rgba(255,255,255,0.3)"
	borderWidth: 1
# 	backgroundColor: "rgba(255,255,255,0.5)"
# 	shadow1: 
# 		blur: 10
	backgroundColor: ""
	clip: true
	z: 10


card_bg = new Layer	
# 	width: Screen.width * 0.8
	width: card_w
	height: card_h
	x: Align.center
	y: 120 + 60
	z: -50
	borderRadius: 10
	backgroundColor: "rgba(255,255,255,0.5)"
# 	backgroundColor: "white"
	shadow1: 
		blur: 16

card_bg.brightness = 0
card_bg.blur = 12
card_bg.opacity = 0.5

card_bg.sendToBack()

random_text_all = []
for i in [0...random_text_num]
	
# 	random_text = new TextLayer
# 		name: "random_text_" + i
# 		parent: card
# 		text: "Lunch"
# 		width: Screen.width * 0.7
# 		height: 60
# 		x: Align.center
# 		y: 20 + random_text_h * i
# 		fontSize: 18
# 		color: "4d4d4d"
# 		textAlign: "center"
# 		backgroundColor: "rgba(255,0,0,0.2)"
# 		backgroundColor: ""
# 		opacity: 1
# 		lineHeight: 3.2
# 		index: i

	random_text = new Layer
		name: "random_text_" + i
		parent: card
		width: 256
		height: 60
		x: Align.center
		y: 20 + random_text_h * i
		backgroundColor: "rgba(255,0,0,0.2)"
		backgroundColor: ""
		opacity: 1
		index: i
		
		html: "Lunch"
		style:
			"fontSize": "18px"
			"color": "#4d4d4d"
			"textAlign": "center"
			"lineHeight": 3.2
			"fontFamily": "#{cwTeXYen}, Arial"
		
	
	random_text_all.push(random_text)
# 	print random_text.id

# =================================


# random_1 = new TextLayer
# 	parent: card
# 	text: "Lunch"
# 	width: Screen.width * 0.9
# 	height: 60
# 	x: Align.center
# # 	y: 120 - 0
# 	y: 20
# 	fontSize: 20
# 	color: "4d4d4d"
# 	textAlign: "center"
# 	backgroundColor: "4fc3c6"
# 	backgroundColor: ""
# 	opacity: 1
# 	borderRadius: 16
# 	lineHeight: 2.3
# 
# random_2 = random_1.copy()
# random_2.parent = card
# random_2.y = random_1.maxY
# random_2.fontSize = random_1.fontSize
# 
# random_3 = random_2.copy()
# random_3.parent = card
# random_3.y = random_2.maxY
# 
# random_4 = random_3.copy()
# random_4.parent = card
# random_4.y = random_3.maxY


# =================================


random_lunch = () ->
	random_text_all[0].html = Utils.randomChoice(lunch_grp_1)
	random_text_all[1].html = Utils.randomChoice(lunch_grp_1)
	while random_text_all[1].html is random_text_all[0].html
		random_text_all[1].html = Utils.randomChoice(lunch_grp_1)
	random_text_all[2].html = Utils.randomChoice(lunch_grp_2)
	random_text_all[3].html = Utils.randomChoice(lunch_grp_3)
	
	current_options = random_text_all[0].html + "  " + random_text_all[1].html + "  " + random_text_all[2].html + "  " + random_text_all[3].html
	
# 	print current_options
	
	current_options_2 = "1. " + random_text_all[0].html + "\n" + "2. " + random_text_all[1].html + "\n" + "3. " + random_text_all[2].html + "\n" + "4. " + random_text_all[3].html
	
	copyToClipboard(current_options_2)

# 	random_text_all[0].text = Utils.randomChoice(lunch_grp_1)
# 	random_text_all[1].text = Utils.randomChoice(lunch_grp_1)
# 	while random_text_all[1].text is random_text_all[0].text
# 		random_text_all[1].text = Utils.randomChoice(lunch_grp_1)
# 	random_text_all[2].text = Utils.randomChoice(lunch_grp_2)
# 	random_text_all[3].text = Utils.randomChoice(lunch_grp_3)
# 
# 	print random_text_all[0].text + "  " + random_text_all[1].text + "  " + random_text_all[2].text + "  " + random_text_all[3].text

# 	random_1.text = Utils.randomChoice(lunch_grp_1)
# 	random_2.text = Utils.randomChoice(lunch_grp_1)
# 	while random_2.text is random_1.text
# 		random_2.text = Utils.randomChoice(lunch_grp_1)
# 	random_3.text = Utils.randomChoice(lunch_grp_2)
# 	random_4.text = Utils.randomChoice(lunch_grp_3)
# 	print random_1.text + "  " + random_2.text + "  " + random_3.text + "  " + random_4.text
# 	print """
# 		#{random_1.text}
# 		#{random_2.text}
# 		#{random_3.text}
# 		#{random_4.text}
# 	"""

# print Utils.randomChoice(lunch_1)
# print Utils.randomChoice(lunch_1)
# print Utils.randomChoice(lunch_2)
# print Utils.randomChoice(lunch_3)

# random_lunch()


# ================================= 


random_btn = new TextLayer
	text: "Shuffle"
	x: Align.center
	y: card.maxY + 40
	fontSize: 24
	color: "white"
	textAlign: "center"
# 	fontFamily: "Arial"
# 	backgroundColor: "4fc3c6"
	backgroundColor: "hsl(240,15%,30%)"
	z: 20
	padding:
		left: 40
		right: 40
	opacity: 1
	lineHeight: 2.3
	shadow1: 
		y: 0
		blur: 2
		color: "rgba(0,0,0,0.1)"
	shadow2: 
		y: 4
		blur: 12
		color: "rgba(0,0,0,0.2)"
	style:
		"background": "linear-gradient( -20deg, hsl(240,10%,30%) 0%, hsl(200,5%,50%) 100%)"	
	borderColor: "hsla(240,30%,85%,0.7)"
	borderWidth: 1
		

random_btn.borderRadius = random_btn.height/2


# tip = new TextLayer
# 	text: "⚠️ COPY Text In Below Logger Window ⬇️"
# 	width: Screen.width * 0.9
# 	height: 50
# 	x: Align.center
# 	y: random_btn.maxY + 30
# 	fontSize: 12
# 	color: "4d4d4d"
# 	textAlign: "center"
# 	backgroundColor: "4fc3c6"
# 	backgroundColor: ""
# 	opacity: 1
# 	borderRadius: 16
# 	lineHeight: 2.3
	


message = new TextLayer
	text: "🎊 Auto Copy Text to Clipboard 🎊"
	width: Screen.width * 0.9
	height: 50
	x: Align.center
	y: random_btn.maxY + 30
	fontSize: 12
	color: "4d4d4d"
	textAlign: "center"
	backgroundColor: "4fc3c6"
	backgroundColor: ""
	opacity: 1
	borderRadius: 16
	lineHeight: 2.3


# btn_get_data = new TextLayer
# 	text: "Update Data from Google Spreadseet"
# 	x: Align.center
# 	y: message.maxY + 0
# 	fontSize: 12
# 	color: "rgba(0,0,0,0.5)"
# 	textAlign: "center"
# # 	backgroundColor: ""
# 	backgroundColor: "hsla(0,0%,100%,0.4)"
# 	padding:
# 		left: 20
# 		right: 20
# 	opacity: 1
# 	lineHeight: 2.3
# 
# btn_get_data.borderRadius = random_btn.height/2




# =================================

updateData()

# btn_get_data.onTap ->
# 	updateData(isUpdated=false)
# 	press_effect(@)
	

particle_all = []
rot_count = 0

ani_option = 
	curve: Spring(damping: 0.9)
	time: 0.8

random_btn.onTap ->
	press_effect(@)
	updateData()
# 	print "isUpdated: " + isUpdated
	rot_count += 1
	card_rotationY = 180 * rot_count

	p.destroy() for p in particle_all
	particle_all = []
	createParticle(_touchX, _touchY) for i in [0...8]
	
# 	Utils.delay 0, ->
	for t in random_text_all
		t.animate
			rotationY: card_rotationY
			options: ani_option
	card.animate
		rotationY: card_rotationY
		options: ani_option
	card_bg.animate
		rotationY: card_rotationY
		options: ani_option
	
	random_btn.text = "Copied!"
	Utils.delay 0.8, ->
		random_btn.text = "Shuffle"
	
	

# random_btn.onTap ->
# 	press_effect(@)
# 	bouncing_ani(card)
# 	bouncing_ani(card_bg)

# random_btn.onTouchStart ->
# 	@.brightness = 90
# 	@.animate( scale: 0.9, options: curve: "ease", time: 0.3 )
# 
# random_btn.onTouchMove ->
# 	@.brightness = 100
# 	@.animate( scale: 1, options: curve: "ease", time: 0.3 )
# 
# random_btn.onTouchEnd ->
# 	@.brightness = 100
# 	@.animate( scale: 1, options: curve: "ease", time: 0.3 )



# # Module
# require 'System'
# # Sensor manager
# sensorManager = getSystemService(Context.SENSOR_SERVICE)
# # Sensor : Orientation
# sensorOrientation = sensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION)
# # print sensorOrientation
# if sensorOrientation
# 	
# 	sensorOrientation.smooth = 0.1
# 	sensorOrientation.onChange (event) ->
# 		print "change"
# 		print event.beta
# 		card.rotationX = -(event.beta) * 0.5 + 0
# 		card = (event.gamma) * 0.5
# 		
# # Sensor : Motion
# sensorMotion = sensorManager.getDefaultSensor(Sensor.TYPE_MOTION)
# if sensorMotion
# 	sensorMotion.smooth = 0.005
# 	sensorMotion.onChange (event) ->
# 		print "sensorMotion change"
# 		card.rotationX -= event.rotationRate.alpha
# 		card.rotationY += event.rotationRate.beta
# 
# 
# accX = 0
# accY = 0
# 
# window.addEventListener 'devicemotion', (event) ->
# 	print event
# 	accX = event.accelerationIncludingGravity.x
# 	accY = event.accelerationIncludingGravity.y * -1
# 
# 	card_bg.midX = card_bg.midX + accX * 3;
# 	card_bg.midY = card_bg.midY + accY * 3;



glow= new Layer
	parent: card
	width: card.width * 4.4
	height: card.width * 2.4
	opacity: 0.4
	borderRadius: '100%'
	z: -10
	blending: Blending.softlight
	
		
card.style =
# 	"background": "linear-gradient( #ffffff 0%, #E6E6E6 100%)"
# 	"background": "linear-gradient( -30deg, hsl(30,10%,90%) 0%, hsl(50,5%,85%) 100%)"
	"background": "linear-gradient( -30deg, hsl(30,10%,98%) 0%, hsl(50,5%,90%) 100%)"	
	
glow.style =
	"background": "radial-gradient( rgba(255,255,255,1) 0%, rgba(255,255,255,0) 60%)"



ratio = 1
center_x = card.width/2
center_y = card.height/2
card.backgroundColor = "hsl(0,0%,95%)"



# card.on Events.TouchMove, (event) ->
# # 	myTouchEvent = Events.touchEvent(event)
# 	delta =
# 		x: (card.midX - Events.touchEvent(event).contextPoint.x) / ratio
# 		y: (card.midY - Events.touchEvent(event).contextPoint.y) / ratio
# 	
# # 	print event.contextPoint.x
# 	
# 	rot = 2
# 	card.rotationX = Utils.modulate delta.y, [0, card.midX], [-rot, rot]
# 	card.rotationY = Utils.modulate delta.x, [0, card.midY], [rot, -rot]
# # 	print card.rotationX
# 	card_bg.rotationX = Utils.modulate delta.y, [0, card.midX], [-rot, rot]
# 	card_bg.rotationY = Utils.modulate delta.x, [0, card.midY], [rot, -rot]
# 	
# # 	card.y = Utils.modulate -delta.y, [0, card.midX], [center_y, center_y - 24]
# # 	card.x = Utils.modulate -delta.x, [0, card.midY], [center_x, center_x - 24]
# 	
# # 	card_inner.midY = Utils.modulate delta.y, [0, card.midY], [center_y, center_y - margin_4]
# # 	card_inner.midX = Utils.modulate delta.x, [0, card.midX], [center_x, center_x - margin_4]
# 	
# 	glow_range = Screen.width/1
# 	glow.x = Utils.modulate delta.x, [0, card.midX], [-glow_range, glow_range]
# 	glow.y = Utils.modulate delta.y, [0, card.midY], [-glow_range/2, glow_range/2]
# 	glow.opacity= Utils.modulate delta.x, [0, card.midX], [0.7, 1]




# =============================== 

# _lifespan	= Utils.randomNumber(0.6, 1)
_velocity 	= 5
_density 	= 50
_maxsize	= 40

radius  = 48
stroke  = 12
viewBox = (radius * 2) + stroke

radius_b  = 12
stroke_b  = 0
viewBox_b = (radius * 2) + stroke

random_color = "#CC66FF"

emoji_assets = ["🍔","🍕","🌮","🥗","🍝","🍜","🍛","🍣","🍱","🥟","🍙"]

createParticle = (posX, posY, image_asset = emoji_assets) ->
	random_color = Utils.randomColor()
	dist = 80
	_lifespan	= Utils.randomNumber(0.6, 1.2)
	_size		= Utils.randomNumber(40, _maxsize)
	_scale		= Utils.randomNumber(0.6, 1)
	_angle		= Utils.randomNumber(0, 360)
	_rise		= Utils.randomNumber(-dist, dist)
# 	_rise		= Utils.randomNumber(-dist*1.5, -dist*0.3)
	_run		= Utils.randomNumber(-dist/1.8, dist/1.8)
	_rotation	= Utils.randomNumber(0, 360)
		
	particle = new TextLayer
		text: Utils.randomChoice(image_asset)
		midX: random_btn.midX
		midY: card.midY + 80
		width: _size 
		backgroundColor: ""
		scale: 0
		opacity: 1
		blur: 10/_size
		style: 
			fill: "red"
		z: 20
	
	particle.bringToFront()
	
	particle_all.push(particle)
	
	particle.animate
		properties:
			scale: _scale
			opacity: 1
		time: 0.2
		curve: "ease-out"

# 	Utils.delay 0, ->
	particle.animate
		properties:
			x: particle.x + _run*_velocity
			y: particle.y + _rise*_velocity
			rotation: _rotation
		curve: "ease-out"
		time: Utils.randomNumber(_lifespan+0, _lifespan+0.4)
# 			time: _lifespan
						
	Utils.delay _lifespan-0.5, ->
		particle.animate
			properties: 
				opacity: 0
# 				scale: 0
			time: 0.5
		Utils.delay 0.5, ->
			particle.destroy()



_touchX = Screen.width
_touchY = Screen.height
	
active = false

random_btn.on Events.TouchEnd, ->
	active = false

# random_btn.onTap ->




# card.onTap ->
# 	copyToClipboard("yyy")
# 	print "Copied!"




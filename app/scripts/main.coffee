console.log '\'Allo \'Allo!'

$body = $(document.body)

circles = {}

createCircle = (id,x,y)->
	console.log 'Creating circle:',id
	$circle = $('<div class="circle">').css
		top: y
		left: x

	circles[id] = $circle
	$circle.appendTo $body

removeCircle = (id)->
	circles[id].remove()
	delete circles[id]
	console.log 'Circle removed:',id

handleTouches = (touchlist)->
	currentIds = []

	for touch in touchlist
		console.log touch.identifier,touch.pageX,touch.pageY
		id = "#{touch.identifier}" # convert to string since object keys are strings.

		currentIds.push id

		if not circles[id]
			createCircle id,touch.pageX,touch.pageY
			console.log 'Circle created:',id,circles
		else
			console.log 'Moving circle:',id,circles
			circles[id].css
				top: touch.pageY
				left: touch.pageX

	for id in _.chain(circles).keys().difference(currentIds).value()
		removeCircle id

$body.on 'touchstart', (event)->
	event.preventDefault()
	handleTouches event.originalEvent.touches

$body.on 'touchend', (event)->
	handleTouches event.originalEvent.touches

$body.on 'touchmove', (event)->
	handleTouches event.originalEvent.touches

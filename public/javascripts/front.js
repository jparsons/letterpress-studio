

// prolly don't need code below this line

function show_more_meta(id) {
	if ($('more_meta_'+id).style.display == 'none') {
		new Effect.SlideDown('more_meta_'+id, {duration: 0.2});
	}
	else {
		new Effect.SlideUp('more_meta_'+id, {duration: 0.2});
	}
	return false;
}
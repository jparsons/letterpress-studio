function show_add_additional() {
	if ($('add_additional').style.display == 'none') {
		new Effect.SlideDown('add_additional', {duration: 0.2});
	}
	return false;
}

function show_event_data() {
	if ($('event_data').style.display == 'none') {
		new Effect.SlideDown('event_data', {duration: 0.2});
	}
	return false;
}

// loads tag highlighting if we need it
window.onload = function()
{
    loading_img = new Image(); // preload indicator image
    loading_img.src = '/images/admin/indicator.gif'; // preload
    el = document.getElementById('tag_input');
    if (el)
    {
        highlight_tags(el);
    }
}

// adds or removes a tag
function tag_swap(el, name)
{
    if (!find_tag(el, name))
    {
        var normalized = el.value.replace(/^\s*|\s*$/g,'');
        el.value = (normalized == '' ? '' : normalized + ' ') + name;
        highlight_tags(el);
    }
    else
    // tag already exists, remove it
    {
        tags = el.value.split(' ');
        new_tags = new Array();
        for (var i = 0; i <= tags.length; i++)
        {
            if (tags[i] != name)
            {
                new_tags[new_tags.length] = tags[i];
            }
        }
        el.value = new_tags.join(' ');
        clear_highlight();
        highlight_tags(el);
    }
}

// see if a tag is already in the block
function find_tag(el, name)
{
    tags = el.value.split(' ');
    for (var i = 0; i <= tags.length; i++)
    {
        if (tags[i] == name)
        {
            return true;   
        }
    }
    return false;
}

// highlights tags that are already there
function highlight_tags(el)
{
    val = el.value.replace(/\,/g, '');
    tags = val.split(' ');
    clear_highlight();
    for (var i = 0; i <= tags.length; i++)
    {
        temp_tag = document.getElementById('tag_' + tags[i]);
        if (temp_tag)
        {
            temp_tag.setAttribute('class', 'tag_tag tag_selected');
        }
    }
}

// clears all highlighted tags
function clear_highlight()
{
    highlighted_tags = getElementsByClass('tag_tag tag_selected');
    for (var x = 0; x < highlighted_tags.length; x++)
    {
        highlighted_tags[x].setAttribute('class', 'tag_tag');
    }
}

// gets an array of all elements with `classname`
function getElementsByClass(classname)
{
    var elements = new Array();
    var inc = 0;
    var alltags = document.all ? document.all : document.getElementsByTagName('*');
    for (var z = 0; z < alltags.length; z++)
    {
        if (alltags[z].className == classname)
        {
            elements[inc++] = alltags[z];
        }
    }
    return elements;
}

// doing update check
function updating(bid, id)
{
    document.getElementById(bid).disabled = true;
    document.getElementById(id).innerHTML = '<img src="/images/admin/indicator.gif" alt="Working" border="0"/> Checking...';
}

// update check done
function update_done(bid, id)
{
    document.getElementById(bid).disabled = false;
    document.getElementById(id).innerHTML = 'Done!';
}



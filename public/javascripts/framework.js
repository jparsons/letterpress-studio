function pop(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
href=mylink;
else
href=mylink.href;
window.open(href, windowname, 'width=300,height=400,scrollbars=yes');
return false;
}

function MM_jumpMenu(targ,selObj,restore){ 
			eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
			if (restore) selObj.selectedIndex=0; }


function popMov(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
href=mylink;
else
href=mylink.href;
window.open(href, windowname, 'width=440,height=440,scrollbars=yes');
return false;
}

function popMp3(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
href=mylink;
else
href=mylink.href;
window.open(href, windowname, 'width=220,height=240,scrollbars=yes');
return false;
}
/*jshint multistr: true */

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel({text: "xml2json example"});
win.add(label);
win.open();

// TODO: write your module tests here
var xml2json = require('ti.xml2json');
Ti.API.info("module is => " + xml2json);

var xmldoc = '<?xml version="1.0" encoding="ISO-8859-1"?>\
<data>\
	<books>\
		<book>\
			<author>001</author>\
			<title>Do Androids Dream of Electric Sheep?</title>\
			<publication>1968</publication>\
			<isbn>0-345-40447-5</isbn>\
		</book>\
		<book>\
			<author>001</author>\
			<title>Do Androids Dream of Electric Sheep?</title>\
			<publication>1969</publication>\
		</book>\
	</books>\
	<authors>\
		<author id="001">\
			Philip K. Dick\
		</author>\
	</authors>\
</data>';


var json = xml2json.convert(xmldoc);

alert(JSON.stringify(json));

xml2json.convertAsync(xmldoc, function(data) {
	alert(JSON.stringify(data.json));
});

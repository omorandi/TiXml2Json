# Titanium xml2json Module

## Description

Parsing XML structures through the DOM API is notoriously cumbersome and inefficient, whilst working with JSON structures is more easily manageable. The TiXml2Json iOS Module allows to offload the translation of large XML strings into JSON objects to native code, thus ensuring a high level of performance, not attainable doing the same in JavaScript through the DOM API.


## Building and installing the Module ##

In order to build the module you must have XCode and the Titanium Mobile SDKs in place. 

The module has been originally developed using the version 2.1.0.GA of the Titanium SDK and the build script expects this version to be present in the system. In case you need to build it against another version of the Titanium SDK, you must modify the `titanium.xconfig` file, changing the `TITANIUM_SDK_VERSION` value accordingly.


The build process can be launched using the build.py script that you find in the module's code root directory. 


In order to build and install the module in your system, simply launch the `install` script from the module project directory.


## Referencing the module in your Titanium Mobile application ##

Simply add the following lines to your `tiapp.xml` file:
    
    <modules>
    	<module platform="iphone" version="1.0.0">ti.xml2json</module>
    </modules>


## Accessing the Module from JavaScript code

### Loading the module

In order to access the module from JavaScript, you should do the following:

	var xml2json = require('ti.xml2json');
	Ti.API.info("module is => " + xml2json);
	


The `xml2json` variable is a reference to the Module object.

### Converting an XML string to a JSON structure

Supposing the `xmlDoc` variable contains an XML string to be converted:

	var jsObj = xml2json.convert(xmldoc);

### Doing an asynchronous conversion

The conversion of large xml documents might block the JavaScript thread for a significant amount of time. In these cases it's more convenient to use the asynchronous version of the `convert()` method, which accepts a callback function for being notified about the result of the conversion:

	xml2json.convertAsync(xmldoc, function(data) {
	    var jsObj = data.json;
    });


## TiXml2Json Module reference

### Methods

* `convert(xmlDoc)`

	* param `xmlDoc`: blob or string containing the xml document to convert
	* return: JS object containing the corresponding JSON structure
	
* `convertAsync(xmlDoc, callback)`

	* param `xmlDoc`: blob or string containing the xml document to convert
	* param `callback`: callback function in the form `function cb(data)`. The JSON object resulting from the conversion can be retrieved through the `json` property of the `data` argument passed to the callback
	

NOTE: in case the conversion cannot take place (e.g. because of invalid 


## License

Copyright (c) 2013 Olivier Morandi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


## NOTICE

The XMLReader.h and XMLReader.m files are Copyright (c) by Troy Brant
Original source code taken from: 
http://troybrant.net/blog/2010/09/simple-xml-to-nsdictionary-converter/
(No license attached)
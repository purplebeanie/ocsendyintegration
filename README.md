Purplebeanie Open Cart Sendy Integration
==============

[Sendy](http://sendy.co/) is an awesome, self hosted mailing list manager.  This extensions allows integration between your OpenCart site and your Sendy mailing list.


##Revision History##

| Version	| Comments	|  
|  ------	| ------	|  
| 0.1	| The initial release and push.  Still very primitive.	|  

## Licence ##

GPL 2.0.  See license.txt.

## Installation ##

1. Install [vQMod](https://code.google.com/p/vqmod/downloads/list), by following the instructions.
2. Upload to your open cart installation using FTP.

## Requirements ##

This extension has been tested on:

* Open Cart 1.5.6
* PHP 5.4 / 5.3
* vqmod-2.4.1-opencart

**You will also need to have curl installed and available for PHP**

## Using the Extension ##

Once the extension is installed go to the **Extensions**->**Open Cart Sendy Integration**  menu item.  This will open the Open Cart Sendy Integration Dashboard and configuration options.

**It is important to do configuration ASAP as failure to do so may result in mysql errors during the account registration process**

![The Sendy Dashboard][configure1]

At present there are only two pieces of data you need to let the system know about:

1. Your Sendy endpoint - give the URL for the Sendy endpoint without the trailing slash.  *ie. http://www-your-sendy-endpoint.com*. 
2. The hashed and encrypted list ID available from your Sendy brand's **Lists** page.


[configure1]:https://dl.dropboxusercontent.com/u/4595431/ocsendyintegration/configure1.jpg width="20cm"
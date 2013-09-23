Purplebeanie Stock Sync for Open Cart
==============

Allows synching of stock in open cart with an external source.


##Revision History##

| Version	| Comments	|  
|  ------	| ------	|  
| 0.1	| The initial release and push.  Still very primitive.	|  

## Licence ##

GPL 2.0.  See license.txt.

## Installation ##

1. Install [vQMod](https://code.google.com/p/vqmod/downloads/list), by following the instructions.
2. Upload to your open cart installation using FTP.
2. From **System**->**Users**->**User Groups** give the user groups who need access access and modifications rights to the **extension/ocstocksync**
3. You will find the extension located in the **Catalog** menu


## Using the Extension ##

The extension is located in the **Catalog** menu.  Click on **Open Cart Stock Sync** to begin.

The main screen is pretty straight forward.

![][main-screen-1]

The table at the top shows the last 5 syncs along with the number of products updated in each sync.

Underneath the table the process for the next sync is broken out into steps 1-3, with a summary of what needs to occur at each step.  To summarise however:

### Step 1 - Define Mappings ###

This step creates the mappings between the spreadsheet and the database tables.  Presently only the following fields in the **oc_products** table will be updated:

* quantity
* stock_staus_id
* price

The **Unique Identifier** input is to specify which column holds the **ID Field** specified in Step 3.  This field is not updated, it is used as a the reference to make changes to the object stored in the **oc_products** table.

### Step 2 - Locate Your File ###

Use the file upload box to browse to the file you wish to upload.  Currently only **csv** files are supported.  I plan to add support for Excel format files in due course.

### Step 3 - Provide ID Field ###

The select box is used to indicated which field is to be used as the unique product identifier.  All the major product identified fields can be used:

* product_id
* model
* sku
* upc
* ean
* jan
* isbn
* mpn

## Credits ##

No work of software stands on it's own.  Thanks goes to the OpenCart team for such an awesome shopping cart.  Also thanks are due to the developers of the Open Bay pro extension which I used as an example of how an OpenCart extension worked.

[main-screen-1]:https://dl.dropboxusercontent.com/u/4595431/ocstocksync/images/main-screen-1.png width="20cm"
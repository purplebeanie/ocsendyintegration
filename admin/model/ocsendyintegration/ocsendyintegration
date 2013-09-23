<?php

require_once(__DIR__.'/simplepie_1.3.1.compiled.php');

class ModelOcstocksyncOcstocksync extends Model
{

	public $boo = '';

  public function __construct($registry)
  {
  	$this->boo = 'boo to you too...';
    parent::__construct($registry);
  }


/**
* the workhouse this does the database update.  TODO: move this to the model
*/

       /*$cat_payment    = $this->db->query("SELECT * FROM `" . DB_PREFIX . "ebay_payment_method`");
        $payments       = array();
        
        foreach($cat_payment->rows as $row){
            $payments[] = $row;
        }*/

  public function update_stock()
  {

  	//pull the column mappings from the POST array
  	$unique_id_field = $_POST['unique_id_field'];
  	$col_unique_id = (int)$_POST['col_unique_id'];
  	$col_quantity = (int)$_POST['col_quantity'];
  	$col_stock_status_id = (int)$_POST['col_stock_status_id'];
  	$col_price = (int)$_POST['col_price'];

  	//check if someone is trying to do a dodgy on the unique_id field....
  	if (!in_array($unique_id_field,array('product_id','model','sku','upc','ean','jan','isbn','mpn')))
  		return false;

  	$count = 0;
	$fh = fopen($_FILES['pricefile']['tmp_name'],'r');
	while(!feof($fh)) {
		$row = fgetcsv($fh);
		//check if this is a data row or header row
		if ((int)$row[$col_unique_id] != 0) {					//casting a string to int will result in 0 ie a header row not a data row.
			$result = $this->db->query("update `".DB_PREFIX."product` set quantity = ".(int)$row[$col_quantity].", stock_status_id = ".(int)$row[$col_stock_status_id].", 
							price = ".(float)$row[$col_price]." where ".$unique_id_field." = ".(int)$row[$col_unique_id]);
			if ($result)
				$count++;
		}

	}
	fclose($fh);

	return $count;
  }

  /**
  * just puts the last syncs into the database
  * @param int the count to insert
  */

  public function update_syncs($count)
  {
  	$this->db->query('insert into `'.DB_PREFIX.'ocstocksync` (`syncdate`,`products`) values (NOW(),'.(int)$count.')');
  }

  /**
  * a small function to verify that necessary dbase tables have been set up to log updates.  checks and creates as needed.
  */

  public function verify_dbase()
  {
  	$this->db->query('create table if not exists `'.DB_PREFIX.'ocstocksync` (`syncdate` date not null default "0000-00-00", `products` int(11) not null default 0)');
  }


  /**
  * gets the synch history from the database for use in the main interface
  * @return array
  */

  public function get_syncs()
  {
  	       /*$cat_payment    = $this->db->query("SELECT * FROM `" . DB_PREFIX . "ebay_payment_method`");
        $payments       = array();
        
        foreach($cat_payment->rows as $row){
            $payments[] = $row;
        }*/
        $results = $this->db->query('select * from `'.DB_PREFIX.'ocstocksync` order by syncdate DESC limit 5');
        $syncs = array();

        foreach ($results->rows as $row)
        	$syncs[] = $row;

        return $syncs;

  }

  /**
  * loads announcmeents from the purplebeanie web site
  * @return array
  */

  public function load_announcements()
  {
  	$feed = new SimplePie();
  	$feed->set_feed_url('http://www.purplebeanie.com/Table/Blog/Open-Cart-Stock-Sync/');
  	$feed->enable_cache(false); //set to false...
  	$feed->init();
  	$items = $feed->get_items();
  	return $items;
  }


}
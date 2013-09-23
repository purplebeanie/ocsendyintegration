<?php

require_once(__DIR__.'/simplepie_1.3.1.compiled.php');

class Modelocsendyintegrationocsendyintegration extends Model
{

	public $boo = '';

  public function __construct($registry)
  {
  	$this->boo = 'boo to you too...';
    parent::__construct($registry);
  }


  /**
  * a small function to verify that necessary dbase tables have been set up to log updates.  checks and creates as needed.
  */

  public function verify_dbase()
  {
  	$this->db->query('create table if not exists `'.DB_PREFIX.'ocsendyintegration` (`dateadded` date not null default "0000-00-00", `email` varchar(256) not null,`ip` varchar(256) not null,`result` varchar(512) not null)');
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
        $results = $this->db->query('select * from `'.DB_PREFIX.'ocsendyintegration` order by dateadded DESC limit 5');
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
  	$feed->set_feed_url('http://www.purplebeanie.com/Table/Blog/Open-Cart-Sendy-Integration/');
  	$feed->enable_cache(false); //set to false...
  	$feed->init();
  	$items = $feed->get_items();
  	return $items;
  }


}
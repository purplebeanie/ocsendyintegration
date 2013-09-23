<?php

class ControllerExtensionOcsendyintegration extends Controller {

	private $strings = array('lang_sync_date','lang_sync_products_updated','lang_no_syncs','lang_checking_version','lang_getting_messages','lang_step_1_title','lang_step_1_desc','lang_step_2_title','lang_step_2_desc','lang_step_3_title','lang_step_3_desc',
							'lang_product_attribute','lang_csv_column','lang_unique_id','lang_please_choose_unique_id','lang_step_4_title','lang_update_stock','lang_form_submission_errors',
                            'lang_read_more_msg');


	/**
	* main method. responds to all actions
	*/

    public function index() 
    {
    	//load language file
    	$this->load->language('extension/ocstocksync');
    	$this->load->model('ocstocksync/ocstocksync');
    	$this->model_ocstocksync_ocstocksync->verify_dbase();

    	if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_POST['task'] == 'processstock') {
    		
    		//repopulate the data in case we want to....
    		foreach (array('unique_id_field','col_unique_id','col_quantity','col_stock_status_id','col_price') as $field)
    			$this->data[$field] = (isset($_POST[$field])) ? $_POST[$field] : null;

    		//do the stock update
    		$count = $this->model_ocstocksync_ocstocksync->update_stock();
    		$this->model_ocstocksync_ocstocksync->update_syncs($count);
    	}

    	//echo $this->model_ocstocksync_ocstocksync->boo.' from controller';

    	//load the breadcrumbs
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('lang_heading_title'),
            'href' => $this->url->link('extension/ocstocksync', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['form_link'] = $this->url->link('extension/ocstocksync','token='.$this->session->data['token'],'SSL');

        //load strings 
        foreach ($this->strings as $str)
        	$this->data[$str] = $this->language->get($str);

        $this->data['last_updated'] = $this->model_ocstocksync_ocstocksync->get_syncs();
        $this->data['announcements'] = $this->model_ocstocksync_ocstocksync->load_announcements();

    	//load and render the view
        $this->template = 'extension/ocstocksync.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );


        $this->response->setOutput($this->render());

    }


    private function validate()
    {
    	return true;
    }
}
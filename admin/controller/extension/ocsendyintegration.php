<?php

class ControllerExtensionocsendyintegration extends Controller {

	private $strings = array('lang_sync_date','lang_sync_email','lang_no_syncs','lang_checking_version','lang_getting_messages','lang_configure_sendy_desc','lang_configure_sendy',
							'lang_form_submission_errors','lang_save_sendy_params','lang_sendy_list_id','lang_sendy_endpoint',
                            'lang_read_more_msg','lang_remote_ip');


	/**
	* main method. responds to all actions
	*/

    public function index() 
    {
    	//load language file
    	$this->load->language('extension/ocsendyintegration');
    	$this->load->model('ocsendyintegration/ocsendyintegration');
        $this->load->model('setting/setting');
        $this->data['settings'] = $this->model_setting_setting->getSetting('ocsendyintegration');
    	$this->model_ocsendyintegration_ocsendyintegration->verify_dbase();

    	if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_POST['task'] == 'savesendyparams') { //why this... make sure people aren't passing dodgy forms!

    		//save the sendy params and populate into the data settings so we can see them
    		$this->model_setting_setting->editSetting('ocsendyintegration',array('sendy_list_id'=>$_POST['sendy_list_id'],'sendy_endpoint'=>$_POST['sendy_endpoint']));
            $this->data['settings'] = array('sendy_list_id'=>$_POST['sendy_list_id'],'sendy_endpoint'=>$_POST['sendy_endpoint']);
    	}


    	//load the breadcrumbs
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('lang_heading_title'),
            'href' => $this->url->link('extension/ocsendyintegration', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['form_link'] = $this->url->link('extension/ocsendyintegration','token='.$this->session->data['token'],'SSL');

        //load strings 
        foreach ($this->strings as $str)
        	$this->data[$str] = $this->language->get($str);

        $this->data['last_updated'] = $this->model_ocsendyintegration_ocsendyintegration->get_syncs();
        $this->data['announcements'] = $this->model_ocsendyintegration_ocsendyintegration->load_announcements();

    	//load and render the view
        $this->template = 'extension/ocsendyintegration.tpl';
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
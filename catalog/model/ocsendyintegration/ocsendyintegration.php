<?php
class Modelocsendyintegrationocsendyintegration extends Model {

	/**
	* just testing
	*/
	
	public static function test()
	{
		error_log('hook in index worked');
	}

	/**
	* adds the custom to the sendy
	* @param array the post array
	*/

	public function add_to_sendy($data)
	{
		//let's get the settings we're going to use for sendy
		$this->load->model('setting/setting');
		$this->load->language('ocsendyintegration/ocsendyintegration');
		$sendysettings = $this->model_setting_setting->getSetting('ocsendyintegration');

		if ((int)$data['newsletter'] != 0) {

			//now POST the settings to sendy...
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $sendysettings['sendy_endpoint'].'/subscribe');
			curl_setopt($ch,CURLOPT_POST,1);
			curl_setopt($ch,CURLOPT_POSTFIELDS,array('name'=>$data['firstname'].' '.$data['lastname'],'email'=>$data['email'],'list'=>$sendysettings['sendy_list_id'],'boolean'=>'true'));
			curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
			$result = curl_exec($ch);
			curl_close($ch);

			if ((int)$result == 1) {
				$this->_update_sendy_log($data,$this->language->get('lang_oc_sendy_success'));
			} else {
				$this->_update_sendy_log($data,$this->language->get('lang_oc_sendy_fail_intro').': '.$result);
			}
		} else {
			$this->_update_sendy_log($data,$this->language->get('lang_oc_sendy_optout'));
		}

	}

	/**
	* updates the sendy db so that we know what records have synced across
	* @param array the data
	* @param string the message
	*/

	private function _update_sendy_log($data,$result)
	{
		$this->db->query('insert into `'.DB_PREFIX.'ocsendyintegration` (`dateadded`,`email`,`ip`,`result`) values (NOW(),"'.$this->db->escape($data['email']).'","'.$this->db->escape($_SERVER['REMOTE_ADDR']).'","'.$this->db->escape($result).'")');
	}
	
}
?>

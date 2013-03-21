<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * Login
 * This is login module for uxapp
 * @package     CodeIgniter
 * @subpackage  Rest Server
 * @category    Controller
 * @author      Blithe Xu
 */

 require APPPATH.'/libraries/REST_Controller.php';
 
 class Dynamic extends  REST_Controller
 {
     /**
      */
     function update_resources_get(){
        if(!$this->get('timestemp')){
            $this->response(array('error' => 'Please pass timestemp'), 400);
        }
        
        $this->response(array(
        					'http://192.168.1.106/cache/img1.png'
        					,'http://192.168.1.106/cache/img2.png'
        					 ), 200);
     }
 }

?>
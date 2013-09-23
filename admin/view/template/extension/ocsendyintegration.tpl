<?php echo $header; ?>
<style>

</style>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if (isset($success) && $success) { ?>
    <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <?php if (isset($error) && $error) { ?>
    <div class="warning"><?php echo $error; ?></div>
    <?php } ?>


    <div class="box">
        <div class="heading">
            <a href="https://github.com/purplebeanie/ocstocksync" target="_BLANK"><h1>Purple Beanie Open Cart Sendy Integration</h1></a>
        </div>
        <div class="content" style="padding-right:0px;">
            <div style="float:left; width:60%;">
                <div style="clear:both;"></div>

                <table class="list">
                    <thead>
                    <tr>
                        <td class="left" width="10%"><?php echo $lang_sync_date;?></td>
                        <td class="center" width="20%"><?php echo $lang_sync_email; ?></td>
                        <td class="left" width="30%"><?php echo $lang_remote_ip;?></td>
                        <td class="left" width="40%"><?php echo $lang_sendy_response;?></td>

                    </tr>
                    </thead>
                    <tbody>
                    <?php if (isset($last_updated)) { ?>
                    <?php foreach ($last_updated as $updates) { ?>
                    <tr>
                        <td class="left"><?php echo $updates['dateadded']; ?></td>
                        <td class="center"><?php echo $updates['email'] ?></td>
                        <td class="left"><?php echo $updates['ip'];?></td>
                        <td class="left"><?php echo $updates['result'];?></td>
                    </tr>
                    <?php } ?>
                    <?php } else { ?>
                    <tr>
                        <td class="center" colspan="4"><?php echo $lang_no_syncs; ?></td>
                    </tr>
                    <?php } ?>
                    </tbody>
                </table>

                <form action="<?php echo $form_link;?>" method="POST" id="update_form" name="update_form" enctype="multipart/form-data">
                    <input type="hidden" name="task" value="savesendyparams"/>
                    <input type="hidden" name="x_required" value="sendy_list_id,sendy_endpoint"/>

                    <h3><?php echo $lang_configure_sendy;?></h3>
                    <?php echo $lang_configure_sendy_desc;?>

                    <table class="list">
                        <tbody>
                            <tr>
                                <td class="left"><?php echo $lang_sendy_endpoint;?></td>
                                <td class="left"><input type="text" name="sendy_endpoint" value="<?php echo (isset($settings['sendy_endpoint'])) ? $settings['sendy_endpoint'] : null;?>"/></td>
                            </tr>
                            <tr>
                                <td class="left"><?php echo $lang_sendy_list_id;?></td>
                                <td class="left"><input type="text" name="sendy_list_id" value="<?php echo (isset($settings['sendy_list_id'])) ? $settings['sendy_list_id'] : null;?>"/></td>
                            </tr>

                        </tbody>
                    </table>

                </form>

                <a class="button" id="btn_update"><?php echo $lang_save_sendy_params;?></a>


               
            </div>
            <div style="float:right; width:40%; text-align:center;">

                <div id="opencart-stock-sync-notification" class="attention" style="background-image:none; margin: 0px 20px; text-align:left;">
                    <?php foreach ($announcements as $announcement) :?>
                        <p><strong><?php echo $announcement->get_title();?></strong><br/><i><?php echo $announcement->get_date();?></i></p>
                        <p><?php echo substr($announcement->get_content(),0,512);?>...</p>
                        <p><a class="button" href="<?php echo $announcement->get_link();?>" target="_blank"><?php echo $lang_read_more_msg;?></a></p>
                    <?php endforeach;?>
                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--

    $(document).ready(function() {
        
        $('#btn_update').on('click',validateForm);
    });

    function validateForm()
    {
        
        var fields = document.getElementById('update_form').x_required.value.split(',');
        var error = false;
        for (var i=0;i<fields.length;i++) {
            var field = fields[i];
            if (document.forms.update_form[field].value == '') {
                error = true;
            }
        }
        if (error) {
            alert('<?php echo $lang_form_submission_errors;?>');
        } else {
            document.getElementById('update_form').submit();
        }
    }

//--></script>
<?php echo $footer; ?>
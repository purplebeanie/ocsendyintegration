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
            <a href="https://github.com/purplebeanie/ocstocksync" target="_BLANK"><h1>Purple Beanie Open Cart Stock Sync</h1></a>
        </div>
        <div class="content" style="padding-right:0px;">
            <div style="float:left; width:60%;">
                <div style="clear:both;"></div>

                <table class="list">
                    <thead>
                    <tr>
                        <td class="left" width="60%"><?php echo $lang_sync_date;?></td>
                        <td class="center" width="40%"><?php echo $lang_sync_products_updated; ?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <?php if (isset($last_updated)) { ?>
                    <?php foreach ($last_updated as $updates) { ?>
                    <tr>
                        <td class="left"><?php echo $updates['syncdate']; ?></td>
                        <td class="center"><?php echo $updates['products'] ?></td>
                    </tr>
                    <?php } ?>
                    <?php } else { ?>
                    <tr>
                        <td class="center" colspan="2"><?php echo $lang_no_syncs; ?></td>
                    </tr>
                    <?php } ?>
                    </tbody>
                </table>

                <form action="<?php echo $form_link;?>" method="POST" id="update_form" name="update_form" enctype="multipart/form-data">
                    <input type="hidden" name="task" value="processstock"/>
                    <input type="hidden" name="x_required" value="unique_id_field,col_unique_id,col_quantity,col_stock_status_id,col_price"/>

                    <h3><?php echo $lang_step_1_title;?></h3>
                    <?php echo $lang_step_1_desc;?>

                    <table class="list">
                        <thead>
                            <tr>
                                <td class="left"><?php echo $lang_product_attribute;?></td>
                                <td class="left"><?php echo $lang_csv_column;?></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="left"><?php echo $lang_unique_id;?></td>
                                <td class="left"><input type="text" name="col_unique_id" value="<?php echo (isset($col_unique_id)) ? $col_unique_id : null;?>"/></td>
                            </tr>
                            <tr>
                                <td class="left">quantity</td>
                                <td class="left"><input type="text" name="col_quantity" value="<?php echo (isset($col_quantity)) ? $col_quantity : null;?>"/></td>
                            </tr>
                            <tr>
                                <td class="left">stock_status_id</td>
                                <td class="left"><input type="text" name="col_stock_status_id" value="<?php echo (isset($col_stock_status_id)) ? $col_stock_status_id : null;?>"/></td>
                            </tr>
                            <tr>
                                <td class="left">price</td>
                                <td class="left"><input type="text" name="col_price" value="<?php echo (isset($col_price)) ? $col_price : null;?>"/></td>
                            </tr>

                        </tbody>
                    </table>

                    <h3><?php echo $lang_step_2_title;?></h3>
                    <?php echo $lang_step_2_desc;?>
                    <input type="file" name="pricefile"/>
                    

                    <h3><?php echo $lang_step_3_title;?></h3>
                    <?php echo $lang_step_3_desc;?>
                    <select name="unique_id_field">
                        <option value=""><?php echo $lang_please_choose_unique_id;?></option>
                        <option value="product_id" <?php echo (isset($unique_id_field) && $unique_id_field == 'product_id') ? 'selected' : null;?> >product_id</option>
                        <option value="model" <?php echo (isset($unique_id_field) && $unique_id_field == 'model') ? 'selected' : null;?> >model</option>
                        <option value="sku" <?php echo (isset($unique_id_field) && $unique_id_field == 'sku') ? 'selected' : null;?> >sku</option>
                        <option value="upc" <?php echo (isset($unique_id_field) && $unique_id_field == 'upc') ? 'selected' : null;?> >upc</option>
                        <option value="ean" <?php echo (isset($unique_id_field) && $unique_id_field == 'ean') ? 'selected' : null;?> >ean</option>
                        <option value="jan" <?php echo (isset($unique_id_field) && $unique_id_field == 'jan') ? 'selected' : null;?> >jan</option>
                        <option value="isbn" <?php echo (isset($unique_id_field) && $unique_id_field == 'isbn') ? 'selected' : null;?> >isbn</option>
                        <option value="mpn" <?php echo (isset($unique_id_field) && $unique_id_field == 'mpn') ? 'selected' : null;?> >mpn</option>
                    </select>

                </form>

                <h3><?php echo $lang_step_4_title;?></h3>
                <a class="button" id="btn_update"><?php echo $lang_update_stock;?></a>


               
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
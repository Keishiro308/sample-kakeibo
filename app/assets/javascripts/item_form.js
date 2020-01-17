$(function(){
  $(document).on("ready turbolinks:load", function() {
    let name_field = $('#item_name');
    name_field.on('focus', function(){
      let error_msg = $(this).next('span.error_msg');
      error_msg.fadeOut();
      $(this).next('label').show();
    });
    name_field.on('blur' ,function(){
      let val = name_field.val();
      if (val.match(/.+/)) {
        name_field.next('label').fadeOut();
      }
    });
    let value_field = $('#value_field');
    value_field.keyup(function(){
      let val = value_field.val();
      if (val === '' || val.match(/\s+/) || val.match(/\D+/)) {
        value_field.addClass('is_error')
      }else {
        value_field.removeClass('is_error')
      }
    });
    value_field.on('focus', function(){
      let error_msg = $('#value_field_wrap').nextAll('.error_message').find('span');
      error_msg.remove();
      $(this).next('label').show();
    });
    value_field.on('blur' ,function(){
      let val = value_field.val();
      if (val === '' || val.match(/\s+/) || val.match(/\D+/)) {
        let error_msg_wrap = $('#value_field_wrap').nextAll('.error_message')
        value_field.addClass('is_error')
        if (val.match(/\D+/)) {
          error_msg_wrap.html('<span class="error_msg">入力できるのは半角数字のみです</span>');
        }else{
          error_msg_wrap.html('<span class="error_msg">入力してください</span>');
        }
      }else {
        value_field.removeClass('is_error')
        value_field.next('label').fadeOut();
      }
    });

    let select = $('#select');
    let select_message_wrap = $('label.select').nextAll('.error_message');
    select.on('change' ,function(){
      let val = select.val();
      let error_msg = select_message_wrap.find('span');
      if (val === '') {
        select.addClass('is_error');
        select_message_wrap.html('<span class="error_msg">入力してください</span>');
      }else {
        select.removeClass('is_error');
        error_msg.remove();
      }
    });

    let item_date = $('#item_date');
    let date_error_wrap = $('.date_field').find('.error_message')
    item_date.on('blur' ,function(){
      let val = item_date.val();
      if (val === '' || val.match(/\s+/)) {
        item_date.addClass('is_error');
        date_error_wrap.html('<span class="error_msg">入力してください</span>');
      }
    });
    item_date.on('change', function(){
      let val = item_date.val();
      if (val === '' || val.match(/\s+/)) {
      }else{
        item_date.removeClass('is_error');
        date_error_wrap.find('span').remove();
      }
    });
  });
});

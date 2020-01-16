$(function(){
  let name_field = $('#item_name');
  name_field.on('focus', function(){
    name_field.next('label').show();
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
    value_field.next('label').show();
  });
  value_field.on('blur' ,function(){
    let val = value_field.val();
    if (val === '' || val.match(/\s+/) || val.match(/\D+/)) {
      value_field.addClass('is_error')
    }else {
      value_field.removeClass('is_error')
      value_field.next('label').fadeOut();
    }
  });

  let select = $('#select');
  select.on('blur' ,function(){
    let val = select.val();
    if (val === '' || val === undefined) {
      select.addClass('is_error')
    }else {
      select.removeClass('is_error')
    }
  });

  let item_date = $('#item_date');
  item_date.on('blur' ,function(){
    let val = item_date.val();
    if (val === '' || val.match(/\s+/)) {
      item_date.addClass('is_error')
    }else {
      item_date.removeClass('is_error')
    }
  });
});

jQuery ->
  $('#item_category_id').parent().hide()
  categories = $('#item_category_id').html()
  $('#item_deartment_id').change ->
    department = $('#item_department_id :selected').text()
    options = $(categories).filter("optgroup[label='#{department}']").html()
    if options
      $('#item_category_id').html(options).parent().show()
    else
      $('#item_category_id').empty().parent().hide()



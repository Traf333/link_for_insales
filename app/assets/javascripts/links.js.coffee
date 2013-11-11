# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  url = 'http://0.0.0.0:3001/sites/1/links.json'
  $.ajax
    url: url
    data: {product_url: location.href}
    dataType: 'jsonp'
    success: (result) ->
      block = $('<div></div>')
      form = $('<form accept-charset="UTF-8" action="http://0.0.0.0:3001/sites/1/links/build_product_url" method="post" style="display:none;"></form>')
      input_char = $('<input name="utf8" type="hidden" value="✓">')
      input_page = $("<input name='product_url' value=#{location.href}>")
      submit = $('<input name="commit" type="submit" value="Import">')
      form.append(input_char, [input_page, submit])
      block.append(form)
      for link in result.links
        img = $("<img src=#{link.image_url}>")
        tag_a = $("<a href=#{link.page_url}></a>")
        tag_a.append(img)
        block.append(tag_a)
        condition = []
        for product in link.products
          condition.push(product.url is location.href)
        unless true in condition
          $("<input name='ids[]' value=#{link.id}>").appendTo(form)
      if true in condition
        form.remove()
      else
        form.submit()

      $('#plant').prepend(block)






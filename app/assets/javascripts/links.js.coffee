# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Скрипт для создания линковки.

$ ->
  block = $('#links_from_alex')
  if block.length
    url = 'http://links-from-alex.herokuapp.com/links'
    category = location.href.split('/product')[0]
    $.ajax
      url: url + '.json'
      data: {product_url: location.href, url: location.origin, category: category}
      dataType: 'jsonp'
      success: (result) ->
        if result.links.length
          form = $("<form accept-charset='UTF-8' action=#{url + '/build_product_url'} method='post' style='display:none;'></form>")
          input_char = $('<input name="utf8" type="hidden" value="✓">')
          input_page = $("<input name='product_url' value=#{location.href}>")
          submit = $('<input name="commit" type="submit" value="Import">')
          form.append(input_char, [input_page, submit])
          block.append(form)
          condition = []
          block.prepend("<h3>Смотрите также:</h3>")
          for link in result.links
            block_link = $("<div class='block_link'></div>")
            img = $("<img src=#{link.image_url}>")
            tag_a = $("<a href=#{link.page_url}></a>")
            p = $("<a href=#{link.page_url}><p>#{link.phrase}</p></a>");
            tag_a.append(img)
            block_link.append(tag_a, [p])
            block.append(block_link)
            unless link.product_url is location.href
              $("<input name='ids[]' value=#{link.id}>").appendTo(form)
            condition.push(link.product_url is location.href)
          if true in condition
            form.remove()
          else
            form.submit()







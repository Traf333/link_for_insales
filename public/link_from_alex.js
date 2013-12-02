(function() {
    var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

$(function() {
    var block, category, url;
    block = $('#links_from_alex');
    if (block.length) {
    url = 'http://links-from-alex.herokuapp.com/links';
    category = location.href.split('/product')[0];
    return $.ajax({
    url: url + '.json',
    data: {
    product_url: location.href,
    url: location.origin,
    category: category
    },
dataType: 'jsonp',
success: function(result) {
    var block_link, condition, form, img, input_char, input_page, link, p, submit, tag_a, _i, _len, _ref;
    if (result.links.length) {
    form = $("<form accept-charset='UTF-8' action=" + (url + '/build_product_url') + " method='post' style='display:none;'></form>");
    input_char = $('<input name="utf8" type="hidden" value="✓">');
    input_page = $("<input name='product_url' value=" + location.href + ">");
    submit = $('<input name="commit" type="submit" value="Import">');
    form.append(input_char, [input_page, submit]);
    block.append(form);
    condition = [];
    block.prepend("<h3>Смотрите также:</h3>");
    _ref = result.links;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    link = _ref[_i];
    block_link = $("<div class='block_link'></div>");
    img = $("<img src=" + link.image_url + ">");
    tag_a = $("<a href=" + link.page_url + "></a>");
    p = $("<a href=" + link.page_url + "><p>" + link.phrase + "</p></a>");
    tag_a.append(img);
    block_link.append(tag_a, [p]);
    block.append(block_link);
    if (link.product_url !== location.href) {
    $("<input name='ids[]' value=" + link.id + ">").appendTo(form);
    }
condition.push(link.product_url === location.href);
}
if (__indexOf.call(condition, true) >= 0) {
    return form.remove();
    } else {
    return form.submit();
    }
}
}
});
}
});

}).call(this);
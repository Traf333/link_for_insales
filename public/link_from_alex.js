(function() {
    var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

$(function() {
    var block, category, url;
    block = $('#links_from_alex');
    block.append("<h3>Смотрите также:</h3>");
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
    var condition, form, img, input_char, input_page, link, product, submit, tag_a, _i, _j, _len, _len1, _ref, _ref1;
    form = $("<form accept-charset='UTF-8' action=" + (url + '/build_product_url') + " method='post' style='display:none;'></form>");
    input_char = $('<input name="utf8" type="hidden" value="✓">');
    input_page = $("<input name='product_url' value=" + location.href + ">");
    submit = $('<input name="commit" type="submit" value="Import">');
    form.append(input_char, [input_page, submit]);
    block.append(form);
    _ref = result.links;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    link = _ref[_i];
    img = $("<img src=" + link.image_url + ">");
    tag_a = $("<a href=" + link.page_url + "></a>");
    tag_a.append(img);
    tag_a.append("<p>" + link.phrase + "</p>");
    block.append(tag_a);
    condition = [];
    _ref1 = link.products;
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
    product = _ref1[_j];
    condition.push(product.url === location.href);
    }
if (__indexOf.call(condition, true) < 0) {
    $("<input name='ids[]' value=" + link.id + ">").appendTo(form);
    }
}
if (__indexOf.call(condition, true) >= 0) {
    return form.remove();
    } else {
    return form.submit();
    }
}
});
}
});

}).call(this);
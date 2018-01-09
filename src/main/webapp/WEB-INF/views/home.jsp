<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Home</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">// <![CDATA[
	function inputFocus(i){
		if(i.value==i.defaultValue){ i.value=""; i.style.color="#000"; }
	}
	function inputBlur(i){
		if(i.value==""){ i.value=i.defaultValue; i.style.color="#848484"; }
	}
</script>

<script>
$(document).ready(function() {
    $("#tagQuery").autocomplete({
        minLength: 1,
        delay: 500,
        source: function (request, response) {
            $.getJSON('<s:url value="/ajaxAra"></s:url>', request, function(result) {
                response($.map(result.key, function(item) {
                    return {
                        label: item.adi + " " + item.soyadi,
                        value: item.adi + " " + item.soyadi,
                        tag_url: '<s:url value="/git/'+item.id+'"></s:url>'
                    }
                }));
            });
        },

        select : function(event, ui) {
            
            if (ui.item) {
                alert("Gidilecek : " + ui.item.tag_url);
                window.location.href = ui.item.tag_url;
                event.preventDefault();
                //$("#selected_tags span").append('<a href=" + ui.item.tag_url + " target="_blank">'+ ui.item.label +'</a>');
                //var defValue = $("#tagQuery").prop('defaultValue');
                //$("#tagQuery").val(defValue);
                //$("#tagQuery").blur();
                return false;
            }
            
        }
    });
});
</script>

<div class="container">
<h1>Değer Arayınız</h1>
<div id="find_keyword">
<div class="ui-widget">
<input id="tagQuery" type="text" name="tagQuery"  onFocus="inputFocus(this)" onBlur="inputBlur(this)" style="width: 300px;padding: 10px;">
</div>
</div>

</div>
</body>
</html>

(function ($) {

    function getCSRF () {
      return $('meta[name="csrf-token"]').attr('content')
    }

    function sameOrigin (url) {
        // Url could be relative or scheme relative or absolute
        var sr_origin = '//' + document.location.host,
            origin = document.location.protocol + sr_origin;

        // Allow absolute or scheme relative URLs to same origin
        return (url == origin || url.slice(0, origin.length + 1) == origin + '/') ||
            (url == sr_origin || url.slice(0, sr_origin.length + 1) == sr_origin + '/') ||
            // or any other URL that isn't scheme relative or absolute i.e relative.
            !(/^(\/\/|http:|https:).*/.test(url));

    }

    $.extend($.ajaxSettings, {
        beforeSend : function (xhr, settings) {console.log(settings);
            if (
                !(/^(GET|HEAD|OPTIONS|TRACE)$/.test(settings.type)) &&
                sameOrigin(settings.url)
            ) {
                xhr.setRequestHeader("X-CSRF-Token", getCSRF());
            }

        }
    });

})(Zepto);
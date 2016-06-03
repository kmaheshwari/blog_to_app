$(function() {

    $('#side-menu').metisMenu();

});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function() {
        return this.href == url || url.href.indexOf(this.href) == 0;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }
});


$(function(){
   $(".placeholder").multiselect({
   selectedText: "# of # selected"
    }); 
   $(document).on("ready", function() {
        $(document).on("click", "#save_draft", function(){
            var formdata = $("#app-form").serialize();
            console.log($(this).data('app'));
            saveDraft($(this).data('app'),$(this).data('author'), formdata);
        });
   });
});
function changecolor(color, element)
{
    var color_value = $(color).val()
    $(element).css("background-color", "#"+color_value);
}
function changeAccentColor(color, element)
{
    var color_value = $(color).val()
    $(element).css("border-bottom-color", "#"+color_value);
} 
function changeTextColor(color, element)
{
    var color_value = $(color).val()
    $(element).css("color", "#"+color_value);
}  
function saveDraft(app_id, author_id, formdata)
{
    categories = $("#app_appcategory_categories").val();
    formdata = formdata + '&app_id=' + escape(app_id) + '&author_id=' + escape(author_id) +'&app[appcategory][categories][]=' + escape(categories) ;
    var params = JSON.parse('{"' + decodeURIComponent(formdata.replace(/&/g, "\",\"").replace(/=/g,"\":\"")) + '"}');
    console.log(params);
    $.ajax({
          type: "POST",
          url: "/save_draft",
          data:  JSON.stringify(params), // the JSON data, as an object or string
          contentType: "application/json",
          dataType: "json",
      });
}

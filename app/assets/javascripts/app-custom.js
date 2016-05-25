
function printname(val) {
var first = $("#fn").val();

         $('#app_name').text(first);
     };


function changecolor(value)
{
     var color_value = $("#color-element").val()
     $("#header-app").css("background-color", "#"+color_value)
     $(".show-color").css("background-color", "#"+color_value)
}     




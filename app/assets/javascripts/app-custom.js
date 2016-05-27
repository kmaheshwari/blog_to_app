// adds app name to phone
function printname(val) {
	var first = $("#fn").val();
    $('#app_name').text(first);
};
// 
function changecolor(value)
{
     var color_value = $("#valueInput").val()
     $("#header-app").css("background-color", "#"+color_value);
     $("#all-categories").css("background-color", "#"+color_value)
     $(".catog-div").css("background-color", "#"+color_value)
     $(".title").css("background-color", "#"+color_value)
}     


function catog()

{
       var catog = " "
       catog = $(".dropdown-toggle").attr("title");
       var chop_catog = catog.split(",");

       if (chop_catog[1] == undefined)
       {
       $("#all-categories").html(chop_catog[0].toUpperCase() + ' ');
       
       }

       else if (chop_catog[2] != undefined )
       {
          $("#all-categories").html(chop_catog[0].toUpperCase() +'&nbsp'+'&nbsp'+'&nbsp'+ chop_catog[1].toUpperCase() +'&nbsp'+'&nbsp'+'&nbsp'+ chop_catog[2].toUpperCase() );

       }  

       else if (chop_catog[1] != undefined && chop_catog[2] == undefined )
       {
          $("#all-categories").html(chop_catog[0].toUpperCase() +'&nbsp'+'&nbsp'+'&nbsp'+  chop_catog[1].toUpperCase());

       }  

}
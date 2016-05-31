
$(document).ready(function() {

  $("#app-form").validate({
                rules: {
                    app_name:
                      {
                        required: true,
                        
                       }
                      ,
                    
                    "author[categories]": 
                    {
                        required: true,
                        // email: true
                    },
                },
            });



});





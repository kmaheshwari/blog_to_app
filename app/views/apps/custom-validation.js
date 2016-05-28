
$(document).ready(function() {

  $("#app-form").validate({
                rules: {
                    app_name:
                      {
                        required: true,
                        
                       }
                      ,
                    
                    categories: 
                    {
                        required: true,
                        // email: true
                    },
                },
            });



});





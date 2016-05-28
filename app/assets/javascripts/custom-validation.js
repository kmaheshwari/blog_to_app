
$(document).ready(function() {


  $("#basicform").validate({
                rules: {
                    blog_url:
                      {
                        required: true,
                        url: true
                       }
                      ,
                    
                    "author_email[]": 
                    {
                        required: true,
                        email: true
                    },
                }
            });

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







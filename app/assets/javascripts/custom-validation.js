
$(document).ready(function() {

  $("#basicform").validate({
                rules: {
                    blog_url: { required: true,url: true },
                    
                    email: {required: true,email: true}
                    ,}
            })


  $("#app-form").validate({
                rules: {
                    app_name: { required: true, }
                      ,
                    
                },

                messages: {
                           app_name: {
                            required: true,
                           },
                          }
            });







});







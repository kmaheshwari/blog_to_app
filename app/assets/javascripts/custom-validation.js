
$(document).ready(function() {

  $("#basicform").validate({
                rules: {
                    blog_url: { required: true,url: true },
                    
                    email: {required: true,email: true}
                    ,}
            })


  $("#app-form").validate({
                rules: {
                    app_name: { required: true, },

                    
                    
                },

                messages: 
                {
                           app_name: {
                            required: "Enter Your App name",
                           }
                }
                
              });

  $("#loginform").validate({
              rules: {
                   "author[email]": { required: true},
                    
                    "author[password]": {required: true}
                    },

                messages: {
                           "author[email]": {required: "Username can't be empty"},

                           "author[password]": {required: "Password can't be empty"}

                          }
            });




});







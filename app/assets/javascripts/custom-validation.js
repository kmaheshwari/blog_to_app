
$(document).ready(function() {

$("#loginform").validate({
rules: {
                   "author[email]": { required: true},
                    
                    "author[password]": {required: true}
                    },

                messages: {
                           "author[email]": {required: "Username can't be empty"},

                           "author[password]": {required: "password Cant be Empty"}

                          }
            });


  $("#basicform").validate({
                rules: {
                    blog_url: { required: true,url: true },
                    
                    email: {required: true,email: true}
                    }
            });


  $("#app-form").validate({
                rules: {
                    app_name: { required: true, },

                    "#categories": { required: true }
                    
                },

                messages: {
                           app_name: {required: "Name of app is missing",},
                          }
            });


  $("#reset-form").validate({
                
      rules: 
      {
        "author[current_password]": { required: true},

       "author[password]": { required: true ,minlength : 8},
                    
       "author[password_confirm]": {required: true,equalTo :"#author[password]"}
                    
        }  ,
        
        messages: 
    {
        "author[password]": {
            required: "Please provide a password",
            minlength: "Your password must be at least 8 characters long"
        },
        "author[password_confirm]": {
            equalTo: "Please enter the same password as above"
        }
        
    }

});







});







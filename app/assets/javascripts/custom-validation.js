
$(document).ready(function() {

  $("#basicform").validate({
                rules: {
                    blog_url: { required: true,url: true },
                    
                    email: {required: true,email: true}
                    ,}
            })


  $("#app-form").validate({

                 onkeyup: function (element, event) {
                        if (event.which === 9 && this.elementValue(element) === "") {
                            return;
                        } else {
                            this.element(element);
                        }
                    },

                    rules: {
                        app_name: { required: true, },
                        email: { required: true, }
                        },

                    messages: 
                    {
                               app_name: {
                                required: "Enter Your App name",
                               }
                    },
                      errorPlacement: function(error, element) {
                        if (element.attr("name") == "app_name") {
                          error.insertAfter("#inputEmail3");
                        } else {
                          error.insertAfter(element);
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







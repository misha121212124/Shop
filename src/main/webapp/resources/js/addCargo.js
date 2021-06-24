   $(document).ready(function() {
    $('#loader').hide();
    $("#submit").on("click", function() {
    	$("#submit").prop("disabled", true);
    	var name = $("#name").val();
        var file = $("#image").val(); 
        var characteristics = $("#characteristics").val();
        var description = $("#description").val();
        var price = $("#price").val();

        var form = $("#form").serialize();
    	var data = new FormData($("#form")[0]);

    	// data.append('name', name);
    	// data.append('characteristics', characteristics);
    	// data.append('description', description);

        $('#loader').show();
        var flag = true;
        if (name === ""){
            flag = false;
            $("#submit").prop("disabled", false);
            $('#loader').hide();
            $("#name").css("border-color", "red");
            $("#error_name").html("Please fill the required field.");
        }
        if (file === ""){
            flag = false;
            $("#submit").prop("disabled", false);
            $('#loader').hide();
            $("#image").css("border-color", "red");
            $("#error_file").html("Please fill the required field.");
        }
        if (characteristics === ""){
            flag = false;
            $("#submit").prop("disabled", false);
            $('#loader').hide();
            $("#characteristics").css("border-color", "red");
            $("#error_characteristics").html("Please fill the required field.");
        }
        if (description === "") {
            flag = false;
            $("#submit").prop("disabled", false);
            $('#loader').hide();
            $("#description").css("border-color", "red");
            $("#error_description").html("Please fill the required field.");
        }
        if (price === "") {
            flag = false;
            $("#submit").prop("disabled", false);
            $('#loader').hide();
            $("#price").css("border-color", "red");
            $("#error_price").html("Please fill the required field.");
        }
        if (flag){
            $("#name").css("border-color", "");
            $("#image").css("border-color", "");
            $("#price").css("border-color", "");
            $("#characteristics").css("border-color", "");
            $("#description").css("border-color", "");

            $('#error_name').css('opacity', 0);
            $('#error_file').css('opacity', 0);
            $('#error_price').css('opacity', 0);
            $('#error_description').css('opacity', 0);
            $('#error_characteristics').css('opacity', 0);

            $.ajax({
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        data: data,
                        url: "/addCargo",
                        processData: false,
                        contentType: false,
                        cache: false,
                        success: function(data, statusText, xhr) {
                        console.log(xhr.status);
                        if(xhr.status == "200") {
                            $('#loader').hide();
                        	$("#form")[0].reset();
                        	$('#success').css('display','block');
                            $("#error").text("");
                            $("#success").html("Product Inserted Succsessfully.");
                            $('#success').delay(4000).fadeOut('slow');
                            $("#submit").prop("disabled", false);
                        }
                        },
                        error: function(e) {


                            $('#loader').hide();
                        	$('#error').css('display','block');
                            $("#error").html("Oops! something went wrong.");
                            $('#error').delay(10000).fadeOut('slow');
                            //location.reload();
                        }
                    });
        }
            });
        });

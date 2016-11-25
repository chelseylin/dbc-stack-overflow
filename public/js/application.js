$(document).ready(function() {
  $(".sidebar").on("click","button#upvote", function(e){
    e.preventDefault();
    current_question_id = $(this).closest("div.question-container").attr("id");
    var request = $.ajax({
      method: "POST",
      url: "/questions/" + current_question_id
    });
    request.done(function(msg){
      console.log(msg)
    });
  });
});

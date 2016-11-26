$(document).ready(function() {
  $(".sidebar").on("click","button#upvote", function(e){
    e.preventDefault();

    var current_question_id = $(this).closest("div.question-container").attr("id");
    var current_points = $(this).closest("div.question-container").find(".points");
    var button = $(this);

    var request = $.ajax({
      method: "POST",
      url: "/questions/" + current_question_id,
      dataType: 'json',
      contentType:"application/json",
      data: {value: 1}
    });
    request.done(function(msg){
      // console.log(msg)
      button.css("color","green");
      current_points.text(msg);
    });
  });

  $(".sidebar").on("click","button#downvote", function(e){
    e.preventDefault();

    var current_question_id = $(this).closest("div.question-container").attr("id");
    var current_points = $(this).closest("div.question-container").find(".points");

    var button = $(this);

    var request = $.ajax({
      method: "POST",
      url: "/questions/" + current_question_id,
      data: {value: -1}
    });
    request.done(function(msg){
      // msg = msg.to_i - 1;
      // console.log(msg);
      // $("body").find(".points").text(msg);
      // $("button#downvote").closest("div.question-container").find(".points").text(msg);
      button.css("color","red");
      current_points.text(msg);
    });
  });

  $(".answer-detail").on("click","#upvote", function(e){
    e.preventDefault();
    var current_answer_id = $(this).closest(".answer-detail").attr("id");
    console.log(current_answer_id);

    var current_points = $(this).closest(".answer-detail").find(".points-small");
    console.log(current_points);

    var button = $(this);
    var request = $.ajax({
      method: "POST",
      url: "/answers/" + current_answer_id + "/vote",
      data: {value: 1}
    });
    request.done(function(msg){
      console.log(msg);
      // button.css("color","red");
      current_points.text(msg);
    });
  });

  $(".answer-detail").on("click","#downvote", function(e){
    e.preventDefault();
    var current_answer_id = $(this).closest(".answer-detail").attr("id");
    console.log(current_answer_id);

    var current_points = $(this).closest(".answer-detail").find(".points-small");
    console.log(current_points);

    var button = $(this);
    var request = $.ajax({
      method: "POST",
      url: "/answers/" + current_answer_id + "/vote",
      data: {value: -1}
    });
    request.done(function(msg){
      console.log(msg);
      // button.css("color","red");
      current_points.text(msg);
    });
  });

});

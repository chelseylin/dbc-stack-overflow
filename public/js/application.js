function votabilityHelper(thingPressed, votableType, voteValue) {
  if(votableType == "question"){
    var pointDiv = ".points";
    var suffix = "container";
  } else {
    var pointDiv = ".points-small";
    var suffix = "detail"
  }

  var targetId = $(thingPressed).closest("." +votableType+"-"+suffix).attr("id");
  var targetPoints = $(thingPressed).closest("." + votableType + "-" + suffix).find(pointDiv);

  var request = $.ajax({
    method: "POST",
    url: "/"+ votableType + "s" +"/" + targetId +"/vote",
    data: {value: voteValue}
  });
  request.done(function(msg){
    console.log(msg)
    if(voteValue == 1){
      var color = "forestgreen";
    }else{
      var color = "red";
    }
    thingPressed.css("color",color);
    targetPoints.text(msg);
  });
  // request.fail(function(msg){
  //   alert("You may not vote on the same item more than once.");
  // });
}

$(document).ready(function() {
  $(".sidebar").on("click","button#upvote", function(e){
    e.preventDefault();
    var buttonPressed = $(this)
    votabilityHelper(buttonPressed, "question", 1);
  });

  $(".sidebar").on("click","button#downvote", function(e){
    e.preventDefault();
    var buttonPressed = $(this);
    votabilityHelper(buttonPressed, "question", -1);
  });

  // function hideButtons() {
  //   document.getElementById("best_answer_button").hide();
  // }

  $(".buttongroup").find("#button").click(function(e){
    e.preventDefault();

    $(this).hide();
  });

  $(".answer-detail").on("click","#upvote", function(e){
    e.preventDefault();
    var buttonPressed = $(this);
    votabilityHelper(buttonPressed, "answer", 1);
  });

  $(".answer-detail").on("click","#downvote", function(e){
    e.preventDefault();
    var buttonPressed = $(this);
    votabilityHelper(buttonPressed, "answer", -1);
  });

  $(".comment-detail").on("click","#upvote", function(e){
    e.preventDefault();
    var buttonPressed = $(this);
    console.log(buttonPressed)
    votabilityHelper(buttonPressed, "comment", 1);
  });

  $(".comment-detail").on("click","#downvote", function(e){
    e.preventDefault();
    var buttonPressed = $(this);
    votabilityHelper(buttonPressed, "comment", -1);
  });

  // Order questions by demand
  $("a.tag-button").on("click", function(event) {
    var request;

    event.preventDefault();
    $("a.tag-button").removeClass("active");
    $(this).addClass("active");

    request = $.ajax({
      url: $(this).attr("href"),
      method: "GET"
    })

    request.done(function(questions) {
      $("div.question-container").html(questions);
    })
  })

  // open up create comment box
  $("a.comment-question").on("click", function(event) {
    event.preventDefault();

    if ($("form.inside-comment-q").hasClass("hidden")) {
      $("form.inside-comment-q").removeClass("hidden");
    } else {
      $("form.inside-comment-q").addClass("hidden");
    }
  })

  $("form.inside-comment-q").submit(function(event) {
    var request;
    event.preventDefault();
    $("form.inside-comment-q").addClass("hidden");
    request = $.ajax({
      url: $(this).attr("action"),
      method: "POST",
      data: $(this).serialize()
    })

    request.done(function(newComment) {
      $(".question-comments").append(newComment);
    })

    request.always(function() {
      $("form.inside-comment-q").find("textarea").val("");
    })
  })

  $(".all-answers").on("click", "a.comment-answer", function(event) {
    event.preventDefault();
    var commentBox = $(this).closest(".answer-detail").find(".inside-comment-a");
    console.log($(this))
    console.log($(this).closest(".answer-detail"))
    console.log(commentBox)

    if (commentBox.hasClass("hidden")) {
      commentBox.removeClass("hidden");
    } else {
      commentBox.addClass("hidden");
    }
  })

  $(".all-answers").on("submit", "form.inside-comment-a", function(event) {
    var request;
    var commentData;
    var answerId = $(this).closest(".answer").attr("id");

    event.preventDefault();
    $(this).addClass("hidden");
    commentData = $(this).serialize();
    $(this).find("textarea").val("");

    request = $.ajax({
      url: $(this).attr("action"),
      method: "POST",
      data: commentData
    })

    request.done(function(newComment) {
      $("div.answer#" + answerId).find(".answer-comments").append(newComment);
    })
  })
});

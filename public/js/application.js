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

});

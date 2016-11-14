
var pageReady = function(){

  
  // REHEARSAL SUBMISSION
  var changeSubmitButton = function(submission, id){
    if(submission === false || !submission){
      $('button.submission').text('Send to Instructor');
      $('button.submission').removeClass('red');
      $('button.submission').addClass('blue');
      $('#rehearsal_'+id+'_status').prop('class', 'blankdot');
    }else{
      $('button.submission').text('Keep as private Rehearsal');
      $('button.submission').removeClass('blue red');
      $('button.submission').addClass('red');
      $('#rehearsal_'+id+'_status').prop('class', 'orangedot');
    }
  }
  
  $(document).on('click', 'button.rehearsal_btn', function() {
    var rehearsalid = $(this).data('rehearsal');
    var rehearsalNumber = $(this).data('rehearsalnumber');
    // console.log(rehearsalNumber);
    // console.log(rehearsalid);

    $.ajax({
      type:'GET',
      url:'/rehearsals/'+rehearsalid+'/api',
      success: function(data){
        // console.log(data);
        $('.put_title_here').html('Rehearsal #'+rehearsalNumber);
        $('.put_video_here').html('<div class="media_wrapper"><div class="ziggeo"><ziggeoplayer ziggeo-theme="modern" class="" ziggeo-video="'+data.video_token+'" ziggeo-stretch ziggeo-responsive> </ziggeoplayer></div></div>');

        $('button.submission').data('rehearsalid', rehearsalid);
        $('button.submission').data('rehearsalsubmission', data.submission);
        changeSubmitButton(data.submission, data.id);
      }
    });
  });

  $(".submission").click(function(){
    var submissionId = $(this).data('rehearsalid');
    var submissionBool = $(this).data('rehearsalsubmission');

    $.ajax({
      type:'PUT',
      url:'/rehearsals/'+submissionId+'/api',
      success: function(data){
        // console.log(data);
        // console.log(data.submission);
        changeSubmitButton(data.submission, data.id);
      }
    });
  });



  // FEEDBACK SUBMISSION
  $('.user_bubble').click(function(event) {
    event.preventDefault();
    var rehearsalid = $(this).data('rehearsalid');
    var courseTitle = $(this).data('coursetitle');
    var topicTitle = $(this).data('topictitle');
    var lessonTitle = $(this).data('lessontitle');

    $.ajax({
      type:'GET',
      url:'/rehearsals/'+rehearsalid+'/api',
      success: function(data){
        var course_lesson_link = '<a href="/courses/'+data.course_id+'/topics/'+data.topic_id+'/lessons/'+data.lesson_id+'/">';
        // console.log(data);
        $('.put_title_here').html('Rehearsal for lesson: '+course_lesson_link+lessonTitle+'</a>');
        $('.put_video_here').html('<div class="media_wrapper"><div class="ziggeo"><ziggeoplayer ziggeo-theme="modern" id="rehearsal_'+rehearsalid+'" ziggeo-video="'+data.video_token+'" ziggeo-stretch ziggeo-responsive> </ziggeoplayer></div></div><br><div style="text-align:left;">Course: '+course_lesson_link+courseTitle+'</a><br> Topic: '+course_lesson_link+topicTitle+'</a></div>');
        $('a.leave_feedback').prop('href','/rehearsals/'+data.id);

        setTimeout(function(){
          var embedding = ZiggeoApi.V2.Player.findByElement($('#rehearsal_'+rehearsalid));
          // console.log(embedding);
          embedding.play();
        }, 500);

        $('.mark_as_completed').data('rehearsalid', data.id);
        $('.leave_feedback').data('rehearsalid', data.id);
        $('.shade_close').delay(1000).addClass('stop_video');
      }
    });
  });

  $('.mark_as_completed').click(function(event) {
    event.preventDefault();
    var thisid = $(this).data('rehearsalid');

    $.ajax({
      type:'PUT',
      url:'/rehearsal/'+thisid+'/rehearsal_approved',
      success: function(data){
        console.log(data);
        $('.mark_as_completed').text('Lesson approved');
      }
    });
  });
  $(document).on('click', '.stop_video', function() {
    var embedding = ZiggeoApi.V2.Player.findByElement('ziggeoplayer');
    embedding.stop();
  });
};

$(document).ready(pageReady);
$(document).on('page:load', pageReady);
$(document).ready(function() {
  window.session = null;
  window.phoneClient = new JsSIP.UA(window.sip_conf);

  phoneClient.on('connected', function(e){ $('#status').html('Connected'); });
  phoneClient.on('disconnected', function(e){ $('#status').html('Disconnected'); });
  phoneClient.on('newRTCSession', function(e){ $('#status').html('In call'); });

  phoneClient.on('registered', function(e){ $('#status').html('Registered'); });
  phoneClient.on('unregistered', function(e){ $('#status').html('Unregistered'); });
  phoneClient.on('registrationFailed', function(e){ $('#status').html('Registration failed'); });

  phoneClient.start();

  $('#call-button').on('click', function(){
    console.log("Start call");

    var selfView =   document.getElementById('my-video');
    var remoteView =  document.getElementById('peer-video');

    // Register callbacks to desired call events
    var eventHandlers = {
      'progress':   function(e){ $('#status').html('In progress'); },
      'failed':     function(e){ $('#status').html('Failed'); },
      'confirmed':  function(e){
        // Attach local stream to selfView
        $('#status').html('Connected');
        selfView.src = window.URL.createObjectURL(session.connection.getLocalStreams()[0]);
      },
      'addstream':  function(e) {
        var stream = e.stream;

        // Attach remote stream to remoteView
        remoteView.src = window.URL.createObjectURL(stream);
      },
      'ended':      function(e){ $('#status').html('Call ended'); }
    };

    var options = {
      'eventHandlers': eventHandlers,
      'mediaConstraints': {'audio': true, 'video': true}
    };

    session = phoneClient.call('sip:test@' + window.my_addr + ':5090', options);

  });





});
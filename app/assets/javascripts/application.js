// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require chartkick
//= require Chart.bundle
//= require jquery
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(function () {
  function eventCalendar() {
      return $('#calendar').fullCalendar({
        locale: 'ja',
        header: {
          left: 'prev, next, today',
          center: 'title',
          right: 'month, agendaWeek, agendaDay'
        },
        navLinks: true,
        events: '/rooms/show.json'
      });
  };
  function clearCalendar() {
      $('#calendar').html('');
  };
  $(document).on('ready turbolinks:load', function () {
    eventCalendar();
  });
  $(document).on('turbolinks:before-cache', clearCalendar);
});


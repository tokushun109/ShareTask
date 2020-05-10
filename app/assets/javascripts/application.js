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
//= require Chart.min
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery

$(function(){

   const $fileField = $('#file');
   const img_field_form = $("#img_field").html();

  $($fileField).on('change', $fileField, function(e) {
    let file = e.target.files[0];
    let files = e.target.files;
    const $preview = $("#img_field");

    if (files.length === 0) {
      $preview.empty();
      $preview.html(img_field_form);
    }else{
      $.each(files, function(index, file) {
        let reader = new FileReader();
        reader.onload = function(e){
          if (index === 0) {
            $preview.empty();
          }
          $preview.append($('<img>').attr({
            src: e.target.result,
            width: "100%",
            class: "preview",
            title: file.name,
            style: "margin-top: 2rem;"
          }));
        };
        reader.readAsDataURL(file);
      });
    }
  });
});

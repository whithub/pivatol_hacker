// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  //var tickets = document.querySelectorAll(".draggable-backlog-tickets");
  //
  //// Get the div element that will serve as the drop target.
  //var dropZoneCurrentSprint = document.querySelector('.drop-zone-current-sprint');
  //
  //// Get the draggable elements.
  ////var dragElements = document.querySelectorAll('.draggable-backlog-tickets');
  //
  //// Track the element that is being dragged.
  //var elementDragged = null;
  //
  //
  //for (var i = 0; i < tickets.length; i++) {
  //  tickets[i].addEventListener('dragstart', function(e) {
  //    console.log('Drag Interaction Started!');
  //    //e.dataTransfer.effectAllowed = 'move';
  //    e.dataTransfer.setData('text', this.innerText);
  //    elementDragged = this;
  //  });
  //
  //  tickets[i].addEventListener('dragend', function(e) {
  //    elementDragged = null;
  //  });
  //
  //};
  //
  //
  //dropZoneCurrentSprint.addEventListener('dragover', function(e) {
  //  console.log("Dragging over Current Sprint");
  //  if (e.preventDefault) {
  //    e.preventDefault();
  //  }
  //
  //  e.dataTransfer.dropEffect = 'move';
  //
  //  return false;
  //});
  //
  ////dropZoneCurrentSprint.addEventListener('dragenter', function(e) {
  ////  console.log("Drag entering Current Sprint Zone");
  ////  this.className = "over";
  ////  e.dataTransfer.dropEffect = 'move';
  ////
  ////});
  //
  ////dropZoneCurrentSprint.addEventListener('dragleave', function(e) {
  ////  console.log("Drag left Current Sprint Zone");
  ////  this.className = "";
  ////});
  //
  //dropZoneCurrentSprint.addEventListener('drop', function(e) {
  //  console.log("Ticket dropped");
  //  if (e.preventDefault) e.preventDefault();
  //  if (e.stopPropagation) e.stopPropagation();
  //
  //  this.className = "";
  //
  //
  //  //document.querySelector('.drop-zone-current-sprint').appendChild(elementDragged);
  //  document.querySelector('#current-sprint-column').appendChild(elementDragged);
  //  //$(elementDragged).appendTo('#current-sprint-column');
  //
  //  document.querySelector('#backlog').removeChild(elementDragged);
  //
  //  return false;
  //});




//=======================================================================================
  //=======================================================================================



// Get the div element that will serve as the drop target.
    var dropZoneOne = document.querySelector('#drop-target-one');

// Get the draggable elements.
    var dragElements = document.querySelectorAll('#drag-elements li');

// Track the element that is being dragged.
    var elementDragged = null;


  for (var i = 0; i < dragElements.length; i++) {

    // Event Listener for when the drag interaction starts.
    dragElements[i].addEventListener('dragstart', function(e) {
      e.dataTransfer.effectAllowed = 'move';
      e.dataTransfer.setData('text', this.innerHTML);
      elementDragged = this;
    });

    // Event Listener for when the drag interaction finishes.
    dragElements[i].addEventListener('dragend', function(e) {
      elementDragged = null;
    });

  };

// Event Listener for when the dragged element is over the drop zone.
    dropZoneOne.addEventListener('dragover', function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }

      e.dataTransfer.dropEffect = 'move';

      return false;
    });

// Event Listener for when the dragged element enters the drop zone.
    dropZoneOne.addEventListener('dragenter', function(e) {
      this.className = "over";
    });

// Event Listener for when the dragged element leaves the drop zone.
    dropZoneOne.addEventListener('dragleave', function(e) {
      this.className = "";
    });

// Event Listener for when the dragged element dropped in the drop zone.
      dropZoneOne.addEventListener('drop', function(e) {
        if (e.preventDefault) e.preventDefault();
        if (e.stopPropagation) e.stopPropagation();

        this.className = "";
        this.innerHTML = "Dropped " + e.dataTransfer.getData('text');

        // Remove the element from the list.
        document.querySelector('#drag-elements').removeChild(elementDragged);

        return false;
      });

});

/*
        SeeMore (for jQuery)
        version: 0.1.0 (16/03/2014)
        @requires jQuery 

        By Senthil Kumar Muthamzihan
        Examples at http://beckproducts.com

        Licensed under the MIT:
          http://www.opensource.org/licenses/mit-license.php

*/


// this function delegates 2 methods on 2 events, 1. on click of see_more_link and 2. on click of see_less_link
(function($) {
  window.SeeMoreEvents = function() {
    this.showMore = $.proxy(this.showMore, this);
    this.showLess = $.proxy(this.showLess, this);
  };

  SeeMoreEvents.prototype = {
    // runs when see more is clicked
    showMore: function(e) {
      var link = e.currentTarget;
      startSwitch(link,"more");
      return false;
    },
    // runs when see less is clicked
    showLess: function(e) {
      var link = e.currentTarget;
      startSwitch(link,"less");
      return false;
    }
  };

  window.seeMoreEvents = new SeeMoreEvents();
  $(document)
    .delegate('a.see_more_link','click',seeMoreEvents.showMore)
    .delegate('a.see_less_link','click',seeMoreEvents.showLess);
})(jQuery);

// Start the process of switching
function startSwitch(lk,t){  
  var fromDb = $(lk).data('from-db');
  // check if fetch from db or just hdie/unhide
  if (fromDb){
    var url = $(lk).data('route');
    // actual fetch from db
    var precontent = $.getJSON( url, function( data ) {
       var field = $(lk).data('field');
       var precontent = data[field];
       prepareContent(t,lk,precontent);
    });
  }else{
    var precontent = $(lk).data('content');
    prepareContent(t,lk,precontent);
  }
}

// prepares content based on more/less
function prepareContent(t,lk,pc){
  if (t == "more"){ switchMoreLess(lk,"more",pc);}
  else if (t == "less"){
    var cSize = $(lk).data('content-size');
    // substring limit set as 20 if not passed by user, else users limit
    var c = pc.substring(0, parseInt(cSize));
    switchMoreLess(lk,"less",c);
  }
}

//this function does the actual switch from less content to more content and changes the link text from more to less and vice versa
function switchMoreLess(lk,t,ctnt){
  t = t || "more";
  if (t == "more"){var opp = "less"}
  else if (t == "less"){var opp = "more"}
  // changing content
  $(lk).closest('.see_more_span').find('.see_more_content').text(ctnt + "...");
  // changing link text
  $(lk).closest('.see_' + t + '_link').text('see ' + opp);
  // toggling class
  $(lk).removeClass('see_' + t + '_link');
  $(lk).addClass('see_' + opp + '_link');
}



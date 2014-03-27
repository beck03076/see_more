describe("On loading the DOM with a SeeMore Link", function() {

  beforeEach(function() {
    loadFixtures('see_more.html');
    cur_name = '.see_more_link'
    cur = $('.see_more_link')
    firstContent = $('.see_more_content').text();
  });
    
  it("a see_more_link with db false, see_more_span, see_more_content should exist", function() {
    expect('.see_more_span').toBeInDOM();
    expect(cur_name).toBeInDOM();
    expect('.see_more_content').toBeInDOM();
    expect($(cur_name).data('from-db')).toEqual(false);
  });
  
  it("the content should be equal to the content_size", function() {
    expect(firstContent.slice(0,-3).length).toEqual(cur.data('content-size'))
  });
  
  describe("Clicking on the see more link", function() {
      
       beforeEach(function() {
         startSwitch(cur,"more"); 
         moreContent = $('.see_more_content').text();
       });
  
      it("should change the class of the link to see_less_link", function() {
        expect('.see_less_link').toBeInDOM();
      });
      
      it("should change the text of the link to see less", function() {
        expect($('.see_less_link').text()).toEqual("see less");
      });
      
      it("should increase the size of the content", function() {
        expect(moreContent.length).toBeGreaterThan(firstContent.length);
      });
      
      describe("Clicking on the see less link", function() {
      
        beforeEach(function() {
         see_less = $('.see_less_link');
         startSwitch(see_less,"less"); 
         lessContent = $('.see_more_content').text();
        });
        
          it("should change the class of the link to see_more_link", function() {
            expect('.see_more_link').toBeInDOM();
          });
          
          it("should change the text of the link to see more", function() {
            expect($('.see_more_link').text()).toEqual("see more");
          });
          
          it("should make the content equal to the first content", function() {
            expect($.trim(lessContent)).toEqual($.trim(firstContent));
          });
      
      });
  
  });

});

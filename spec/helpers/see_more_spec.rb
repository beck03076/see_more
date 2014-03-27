require 'spec_helper'

require 'see_more/helper'
include SeeMore::SeeMoreHelpers

DB = Sequel.sqlite
DB.create_table(:my_models) do
  primary_key :id, :auto_increment => true
  Bignum :status_bits, :null => false, :default => 0
  String :desc, null: false, default: "This is a default text"
end
        
class MyModel < Sequel::Model
  plugin :bit_fields, :status_bits, [ :started, :finished, :reviewed ]
end
describe "Going to test the see_more_helper" do
    before do        
            @obj = MyModel.create
            @obj.desc = "The warden threw a party in the county jail
                                The prisonband was there and they began to wail
                                The joint was jumping and the place began to swing
                                You should have heard those knocked out jailbirds sing

                                Lets rock
                                Everybody lets rock
                                Everybody on the whole cell block
                                They was dancing to the jailhouse rock

                                Spider murphy played the tenor saxophone
                                Little joe was blowin on the slide trombone
                                The drummerboy from illinois went crash boom bang
                                The whole rhythm section was the purple gang"
            @obj.save
    end
        
    describe "w/o opts" do
      before do 
         @nk = Nokogiri::HTML.parse(see_more @obj, :desc)
      end

        it "should generate a span with class see_more_span" do
          span = @nk.css("span")
          span.attribute("class").value.should == "see_more_span"
        end
        
        it "should generate a span inside see_more_span as see_more_content" do
          @nk.css('span.see_more_span > span.see_more_content').first != nil
        end
        
        it "should generate a link with class see_more_link" do
          @nk.css('span.see_more_span > a.see_more_link').first != nil
        end
        
        it "see_more_link's text should be see more" do
          @nk.css('span.see_more_span > a.see_more_link').first.text == "see more"
        end
        
        it "content length should be data-content-size" do
          ctnt_size = @nk.css('span.see_more_span > a.see_more_link').attribute('data-content-size').value
          ctnt = @nk.css('span.see_more_span > span.see_more_content').first.text
          ctnt_size == ctnt.size
        end
    end
    
    describe "with opts" do

        it "should contain all the classes in main span passed in opts" do
          cls = "first second"
          @nk = Nokogiri::HTML.parse(see_more @obj, :desc,{classes: cls})
          cl_arr = @nk.css('span.see_more_span').attribute('class').value.split(" ")
          (cls.split(" ") - cl_arr).size == 0
        end
        
        it "should contain all the classes in link passed in opts" do
          cls = "first second"
          @nk = Nokogiri::HTML.parse(see_more @obj, :desc,{link_classes: cls})
          cl_arr = @nk.css('span.see_more_span > a.see_more_link').attribute('class').value.split(" ")
          (cls.split(" ") - cl_arr).size == 0
        end
        
        it "should have data-content-size as passed in opts" do
          passed = 10
          @nk = Nokogiri::HTML.parse(see_more @obj, :desc,{content_size: passed})
          formed = @nk.css('span.see_more_span > a.see_more_link').attribute('data-content-size').value
          formed == passed
        end
        
        it "should have from_db as passed in opts" do
          passed = true
          @nk = Nokogiri::HTML.parse(see_more @obj, :desc,{from_db: passed})
          formed = @nk.css('span.see_more_span > a.see_more_link').attribute('data-from-db').value
          formed == passed
        end
        
        it "should have from_db as passed in opts" do
          passed = "/a/path"
          @nk = Nokogiri::HTML.parse(see_more @obj, :desc,{route: passed})
          formed = @nk.css('span.see_more_span > a.see_more_link').attribute('data-route').value
          formed == passed
        end
    end

end

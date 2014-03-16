# SeeMore

**see_more** gem is pretty straight forward in truncating and displaying any large text in a small space with a "see more" link in the end. If clicked, this link shows the entire text and the "see more" link automatically toggles to "see less" link. That's all. 

Also, this assumes that the server has standard defined REST methods.

## Installation

Add this line to your application's Gemfile:

    gem 'see_more'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install see_more

## Usage

To display the description of a product with see_more, you would do this.

In your application.js,

    //= require see_more
    
In your view(ideally show.html.erb)    

    <%= see_more @product,:desc, {db: true,link_classes: "clickable",classes: "light",content_size: 30} %>

###see_more

Params:

- **object** (Mandatory): The Object parameter represents the object itself(the active record object).
- **field** (Mandatory): The field (passed as symbol) is the attribute of the Object you are going to display as large text.


Options:

- **:classes** Displaying of text is inside a span with a class="see_more_span". You can add more classes through this option.
- **:link_classes**: You can add more classes to the "see more" link.
- **:content_size**: The number of characters to be displayed intially with the "see more" link.
- **:db**: Value can either be "true" or "false". If its true, only when you click on the link, the entire text is fetched from the db, if its false, even before clicking on the link, the entire text is rendered, it just hides/unhides the content.
- **:path**: If you want to visit a custom link, instead of a REST method, pass the url in this option.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

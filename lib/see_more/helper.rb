module SeeMore
  module SeeMoreHelpers
    def see_more(object,field,opts = {})
      content = object.send(field)
      route = object.class.name.downcase + "_path"
      
      if !content.blank?
          # setting classes to main span from opts as array
          classes = ["see_more"]
          unless opts[:classes].nil?
            classes << opts[:classes]
            classes.flatten!
          end
          # by default 20 chars will be displayed
          ctnt_size = opts[:content_size] || 20
          ctnt = truncate(content,length: ctnt_size)
          # creating the actual content and the link
          out =  "<span class='#{classes.join(" ")}'>"
          out << ctnt          
          out link_to "see more",
                      send(route,*[object,{format: "json"}]),
                      {remote: true}
          out << "</span>"
          out
       end
    end
  end
end


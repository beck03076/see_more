module SeeMore
  module SeeMoreHelpers
      def see_more(object,field,opts = {})
          content = object.send(field)
          if !content.blank?
              # setting classes to main span from opts as array
              classes = ["see_more_span"]
              unless opts[:classes].nil?
                classes << opts[:classes]
                classes.flatten!
              end
               # setting classes to see more link from opts as array
              lk_classes = ["see_more_link"]
              unless opts[:link_classes].nil?
                lk_classes << opts[:link_classes]
                lk_classes.flatten!
              end
              # by default 20 chars will be displayed
              ctnt_size = opts[:content_size] || 20
              ctnt = content[0..ctnt_size]
              # if you want the data to be fetch from db
              frm_db = opts[:db] || false
              if frm_db
              # path can be changed if not the default show method of the current object is used(assuming restful routes)
                rte = opts[:path] || send(object.class.name.downcase + "_path",*[object,{format: "json"}])
              else
                rte = "db-false"
              end
              # creating the actual content and the link
              out =  "<span class='#{classes.join(" ")}'><span class='see_more_content'>"
              out << ctnt
              out << "...</span>"
              out << link_to("see more",
                          "#",
                          {data: {content_size: ctnt_size,
                                  from_db: frm_db,
                                  route: rte,
                                  field: field.to_s,
                                  content: content},
                          class: lk_classes})
              out << "</span>"
              out.html_safe
           end
      end
  end
end


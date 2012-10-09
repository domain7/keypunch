module GroupsHelper
  def display_tree(node=nil)
    fuc = lambda do |nodes|
      return "" if nodes.empty?
      return "<ul>" +
        nodes.inject("") do |string, (node, children)|
        if children.empty?
          node_title = link_to(node.title, node)
        else
          node_title = "<span>" + node.title + "</span>"
        end
        string + "<li rel='#{node.id}'>" +
        node_title +
        fuc.call(children) +
        "</li>"
        end +
          "</ul>"
    end
    if node.nil?
      out = ''
      Group.roots.each do |node|
        if node.descendants.empty?
          node_title = link_to(node.title, node)
        else
          node_title = "<span>#{node.title}</span>"
        end
        out +="<ul class='tree simpleTreemenu'><li rel='#{node.id}'>" +
        node_title +
        fuc.call(node.descendants.arrange) +
        "</li></ul>"
      end
      out
    else
      fuc.call(node.descendants.arrange)
    end
  end

  def group_nav(node=nil)
    if node.nil?
      group_list = Group.roots
    else
      group_list = node.children
    end

    out = "<ul>"
    group_list.each do |g|
      out += "<li>" + link_to(g.title, g) + "</li>"
    end
    out += "</ul>"
    return out
  end
end

module ApplicationHelper

  def is_current_nav?(name, options = {:is_true => 'active', :is_false => ''})
    if name == @main_nav
      return options[:is_true]
    end
  end

  def title(str)
    content_for(:title) { str.to_s }
    str
  end

  def sortable(column, title=nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def breadcrumbs
    group = @group if @group
    group = @entity.group if @entity

    out = ''

    if group
      out = "<li>#{link_to("Home", root_path)}<span class=\"divider\">/</span></li>"
    end

    out
  end

  def display_breadcrumb_trail(group, link_current=false)
    safe_concat "\r\n\t<li>#{link_to('Home', entities_path)} <span class=\"divider\">/</span></li>"
    group.path.each do |g|
      if group.path.last.title != g.title
        safe_concat "\r\n\t<li>#{link_to(g.title, group_path(g))} <span class=\"divider\">/</span></li>"
      else
        if link_current
          safe_concat "\r\n\t<li>#{link_to(g.title, group_path(g))}</li>"
        else
          safe_concat "\r\n\t<li class=\"active\">#{group.title}</li>"
        end
      end
    end
    ''
  end
end

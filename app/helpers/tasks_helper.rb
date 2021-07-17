module TasksHelper
  def display_tag(tag_names)
    tag_names.map { |name| link_to name, tag_path(name) }.join(', ').html_safe
  end
  def transfer_priority(priority)
    if priority == "1"
      "低"
    elsif priority == "2"
      "中"
    elsif priority == "3"
      "高"
    end
  end
end
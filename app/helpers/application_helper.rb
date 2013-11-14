module ApplicationHelper
  def s(score, options = {})
    if current_user && (current_user.id == options[:user_id] || current_user.finished_registration?)
      if score.is_a? Float
        '%.2f' % score
      else
        score.to_s
      end
    else
      I18n.t('assessments.blinded_score')
    end
  end

  def c(content, options = {})
    if current_user && (current_user.id == options[:user_id] || current_user.finished_registration?)
      content
    else
      I18n.t('assessments.blinded_content')
    end
  end

  def star_rating_div(score, read_only, id_str)
    width = 0
    class_str = ''
    ul_element = ''

    if read_only
      width = score * Float(20)
      class_str = 'star_rating_readonly'
      ul_element = content_tag('ul', 
                               content_tag('li', '', class: 'current-rating', style: "width:#{width}px;").html_safe +
      '<li><a class="one-star"></a></li>'.html_safe +
      '<li><a class="two-stars"></a></li>'.html_safe +
      '<li><a class="three-stars"></a></li>'.html_safe +
      '<li><a class="four-stars"></a></li>'.html_safe +
      '<li><a class="five-stars"></a></li>'.html_safe, 
      class: 'star-rating')

    else
      width = score * Float(30)
      class_str = 'star_rating_large'
      ul_element = content_tag('ul', 
                               content_tag('li', '', class: 'current-rating', style: "width:#{width}px;").html_safe +
      '<li><a onclick="starClicked(this)" class="one-star"></a></li>'.html_safe +
      '<li><a onclick="starClicked(this)" class="two-stars"></a></li>'.html_safe +
      '<li><a onclick="starClicked(this)" class="three-stars"></a></li>'.html_safe +
      '<li><a onclick="starClicked(this)" class="four-stars"></a></li>'.html_safe +
      '<li><a onclick="starClicked(this)" class="five-stars"></a></li>'.html_safe, 
      class: 'star-rating')

    end


    content_tag('div', ul_element.html_safe, class: class_str, id: id_str)
  end
end

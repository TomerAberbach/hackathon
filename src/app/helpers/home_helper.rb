module HomeHelper
  ##
  # Prints the date and time range of the hackathon in a presentable format.
  def datetime_range
    if !@metadata.start_date.nil? and !@metadata.end_date.nil?
      start_datetime = @metadata.start_date.strftime('%Y-%m-%d')
      start_text = @metadata.start_date.strftime('%B&nbsp;%-d')

      end_datetime =@metadata.end_date.strftime('%Y-%m-%d')
      end_text = @metadata.end_date.strftime("%B&nbsp;%-d")

      if !@metadata.start_time.nil? and !@metadata.end_time.nil?
        start_datetime += "T#{@metadata.start_time.strftime('%H:%M:%S')}"
        start_text += "&nbsp;at&nbsp;#{@metadata.start_time.strftime('%-I:%M&nbsp;%p')}"

        end_datetime += "T#{@metadata.end_time.strftime('%H:%M:%S')}"
        end_text += "&nbsp;at&nbsp;#{@metadata.end_time.strftime('%-I:%M&nbsp;%p')}"
      end

      start_datetime_text = "<time datetime=\"#{start_datetime}\">#{start_text}</time>"
      end_datetime_text = "<time datetime=\"#{end_datetime}\">#{end_text}</time>"

      "<p class=\"text-base sm:text-xl md:text-2xl mb-3\">#{start_datetime_text} to #{end_datetime_text}</p>".html_safe
    else
      ''
    end
  end

  def address
    text = ''

    unless @metadata.address_one.blank?
      text += escape_once(@metadata.address_one)

      unless @metadata.address_two.blank?
        text += "<br>#{escape_once(@metadata.address_two)}"
      end
    end

    unless @metadata.city.blank?
      unless text.blank?
        text += '<br>'
      end

      text += escape_once(@metadata.city)

      unless @metadata.state.blank?
        text += ", #{escape_once(@metadata.state)}"

        unless @metadata.zip_code.blank?
          text += " #{escape_once(@metadata.zip_code)}"
        end
      end

      if text.blank?
        ''
      else
        "<p class=\"text-base sm:text-xl md:text-2xl mb-3\">#{text}</p>".html_safe
      end
    end
  end
end

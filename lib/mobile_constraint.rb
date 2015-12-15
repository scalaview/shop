class MobileConstraint
  def matches?(request)
    return true if Rails.env == 'development'
    return false if request.user_agent.to_s.downcase =~ Regexp.new('ipad|android 3.0|xoom|sch-i800|gt-p1000|playbook|tablet|kindle|honeycomb|nexus 7')
    # return request.session['mobile_view'] if request.session['mobile_view']
    request.user_agent.to_s.downcase =~ Regexp.new('palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                                                   'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                                                   'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                                                   'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                                                   'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile|zune')
  end
end
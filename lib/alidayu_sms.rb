require "alidayu_sms/version"
require 'net/http'
# require "yaml"
# require "active_support/all"
# require 'alidayu_sms/configuration'
require_relative 'alidayu_sms/configuration'
# Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/lib/alidayu_sms/*.rb").each do |f|
#   require f
# end

module AlidayuSms

  extend self

  # Send_Url = 'http://gw.api.taobao.com/router/rest'

  def configure
    yield config
  end

  def config
    @config ||= Configuration.new
  end

  def reset_config
    @config = nil
  end

  def send(options = {})
    public_options = {
      method: 'alibaba.aliqin.fc.sms.num.send',
      app_key: AlidayuSms.config.app_key,
      target_app_key: options[:target_app_key],
      sign_method: options[:sign_method] || 'md5',
      session: options[:session],
      timestamp: Time.now.strftime("%F %H:%M:%S"),
      format: options[:format] || 'json',
      v: '2.0',
      partner_id: options[:partner_id]
    }

    method_options = {
      sms_type: 'normal',
      sms_free_sign_name: options[:sms_free_sign_name],
      sms_param: options[:sms_param],
      rec_num: options[:rec_num],
      sms_template_code: options[:sms_template_code]
    }

    req_options = public_options.merge method_options
    req_options[:sign] = sign(req_options)

    res = Net::HTTP.post_form(URI.parse(AlidayuSms.config.request_url), req_options)
    puts res.body
  end

  private
  def sign(options)
    sign_str = AlidayuSms.config.app_secret + options.delete_if{|key, val| val.nil? }.sort.join + AlidayuSms.config.app_secret
    Digest::MD5.hexdigest(sign_str).upcase
  end
end

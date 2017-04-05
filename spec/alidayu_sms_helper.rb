require "spec_helper"
require "active_support/all"

describe "test send sms api" do
  before do
    AlidayuSms.configure do |config|
      config.app_key = "23715176"
      config.app_secret = "2ccddb42a86244f7daad882edc91bac9"
      config.request_url = "http://gw.api.taobao.com/router/rest"
    end
  end

  it "send message success" do
    options = {"rec_num": "17721016972", "sms_template_code": "SMS_57375092", "sms_param": "#{{name: 'test', code: '123323'}.to_json}", "sms_free_sign_name": "邹锦富测试" }
    res = JSON.parse(AlidayuSms.send(options).body)

    expect(res["alibaba_aliqin_fc_sms_num_send_response"]["result"]["success"]).to eq(true)
  end

  it "send message fail" do
    options = {"rec_num": "17721016972", "sms_template_code": "SMS_57375092", "sms_param": "{name: 'test'}", "sms_free_sign_name": "邹锦富测试" }
    res = JSON.parse(AlidayuSms.send(options).body)

    expect(res["error_response"]).to be_an_instance_of(Hash)
  end
end

require "spec_helper"
require "active_support/all"

describe "test send sms api" do
  before do
    AlidayuSms.configure do |config|
      config.app_key = ""
      config.app_secret = ""
      config.request_url = ""
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

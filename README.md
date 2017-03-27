# AlidayuSms

alidayu send message api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alidayu_sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alidayu_sms

## Usage

```ruby
AlidayuSms.configure do |config|
  config.app_key = :your_app_key
  config.app_secret = :your_app_secret
  config.request_url = :alidayu_api_url #["http://gw.api.taobao.com/router/rest", "https://eco.taobao.com/router/rest"]
end

options = {"rec_num": "rec_num", "sms_template_code": "sms_template_code", "sms_param": "sms_params", "sms_free_sign_name": "sms_free_sign_name" }

AlidayuSms.send(options)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Darchro/alidayu_sms.


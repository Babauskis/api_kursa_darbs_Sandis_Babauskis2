require_relative 'features/support/api_helper.rb'
require 'json'

class Percent
  def percent(number)
    self.to_f / number.to_f * 100
  end
end

build_number = ARGV[0]
job_name = ARGV[1]
link_to_report = ARGV[2]


report = File.open('report.json').read
hash = JSON.parse(report)


#hash[0].each do |test|
#if test['status'] != 'passed'
#  test_passed = false else
#  if test['status'] = 'passed'
#test_passed = true
#  end
#  if test_passed
#    test_passed + 1
#  else
#    test_passed
#  end
#end


thumbnail = {'url' => 'http://moziru.com/images/zucchini-clipart-cucumber-15.png'}
fields =[]
fields.push({'name' => 'Build name', 'value' => job_name})
fields.push({'name' => 'Build number', 'value' => build_number.to_s})
fields.push( {'name' => 'Link to Report',  'value' => link_to_report})

embed = []
embed.push('color' => 10879231,
            'thumbnail' => thumbnail,
           'fields' => fields)
payload = {'embeds' => embed }.to_json

post("https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1",
     headers: {'Content-Type' => 'application/json'},
     cookies: {},
     payload: payload)
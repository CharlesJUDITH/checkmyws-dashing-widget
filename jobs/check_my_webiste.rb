#!/bin/env ruby
require 'net/http'
require 'json'
require 'uri'
require 'httparty'

url = "https://api.checkmy.ws/api/status"
check = {
	"yourcheckid" => "yourcheckdescription",
	"yourcheckid2" => "yourcheck2description"
}

overall_status='0'
SCHEDULER.every '5m', :first_in => 0 do |job|
result = Array.new
        check.each do |check_key, check_name|
		response = HTTParty.get("#{url}/#{check_key}")
		json = JSON.parse(response.body)
		status = json['state']

               if status == "2"
                        result.push({
                                label: check_name,
                                value: status
                        })
                overall_status='critical'
                end
        end
                if overall_status == "0"
                        # If there is no error, print All checks: UP
                        result.push({
                                label: 'ALL checks',
                                value: 'OK'
                        })
                end

        # Send data to the widget if everything is OK
        send_event('external_checks', { items: result, overall_status: overall_status })
end

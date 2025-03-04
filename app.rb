require "sinatra"
require "sinatra/reloader"
require "http"



get("/") do

  @api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_data= HTTP.get(@api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  @symbols = parsed_data.fetch("currencies")

erb(:home_page)

end

get("/:from_currency")do 


 @original_currency = params.fetch("from_currency")

 @api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

raw_data= HTTP.get(@api_url)

raw_data_string = raw_data.to_s

parsed_data = JSON.parse(raw_data_string)

@symbols = parsed_data.fetch("currencies")

erb(:from_currency)

end

get("/:from_currency/:to_currency")do 

@original_currency = params.fetch("from_currency")

@destination_currency = params.fetch("to_currency")


@api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"


@raw_data= HTTP.get(@api_url)

@raw_data_string = @raw_data.to_s


@parsed_data = JSON.parse(@raw_data_string)

erb(:convert)
end

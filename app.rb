require_relative 'time_format'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    if @request.path_info == "/time"
      time_response
    else
      make_response(404, "Not found!\n")
    end
  end

  private

  def make_response(status, body)
    @response.status = status
    @response.header['ContentType'] = 'text/plain'
    @response.write(body.to_s)
  end

  def time_response
    response = TimeFormat.new(@request.params)

    if response.valid?
      make_response(200, response.call)
    else
      make_response(400, "Unknown time format #{response.unknown_formats}\n")
    end
  end
end
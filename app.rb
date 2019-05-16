require_relative 'time_form'

class App
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    if @request.path_info == "/time"
      response = TimeFormat.new(@request.params)

      if response.valid?
        fix_response(200, response.call)
      else
        fix_response(400, "Unknown time format #{response.unknown_formats}\n")
      end

    else
      fix_response(404, "Not found!\n")
    end
  end

  private

  def fix_response(status, body)
    @response.status = status
    @response.header['ContentType'] = 'text/plain'
    @response.write(body.to_s)
  end
end
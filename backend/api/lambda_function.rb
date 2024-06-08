require 'json'
require 'rack'
require_relative 'config/environment'

def handler(event:, context:)
  app = Rails.application

  request_env = {
    'REQUEST_METHOD' => event['httpMethod'],
    'PATH_INFO' => event['path'],
    'QUERY_STRING' => event['queryStringParameters']&.to_query || '',
    'SERVER_NAME' => 'localhost',
    'rack.input' => StringIO.new(event['body'] || ''),
    'rack.url_scheme' => 'http'
  }.merge((event['headers'] || {}).transform_keys { |k| "HTTP_#{k.upcase.tr('-', '_')}" })

  status, headers, body = app.call(request_env)

  {
    statusCode: status,
    headers: headers,
    body: body.join
  }
end

require "rack/auth/request/version"

module Rack
  module Auth
    class Request
      def initialize(app, auth)
        @app, @auth = app, auth
      end

      def call(env)
        auth_response = @auth.call(env)

        return unauthorized if auth_response[0] == 401
        return forbidden if auth_response[0] == 403

        return @app.call(env) if 200 <= auth_response[0] && auth_response[0] < 300

        ise
      end

      private

      def unauthorized
        return [
          401,
          {
            CONTENT_TYPE => 'text/plain',
            CONTENT_LENGTH => '0'
          },
          []
        ]
      end
      def forbidden
        return [
          403,
          {
            CONTENT_TYPE => 'text/plain',
            CONTENT_LENGTH => '0'
          },
          []
        ]
      end
      def ise
        return [
          500,
          {
            CONTENT_TYPE => 'text/plain',
            CONTENT_LENGTH => '0'
          },
          []
        ]
      end
    end
  end
end

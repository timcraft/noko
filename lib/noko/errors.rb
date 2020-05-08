module Noko
  Error = Class.new(StandardError)

  ClientError = Class.new(Error)

  ServerError = Class.new(Error)

  AuthenticationError = Class.new(ClientError)

  NotFound = Class.new(ClientError)
end

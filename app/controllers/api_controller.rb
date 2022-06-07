
class ApiController < ApplicationController
  class BadRequestHeaderError < StandardError; end
  class UnauthorizedError < StandardError; end
  
  rescue_from BadRequestHeaderError, with: :bad_request_header_error
  rescue_from UnauthorizedError, with: :unauthorized_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  skip_before_action :verify_authenticity_token
  before_action :verify_requested_format!
  
  private

  def verify_requested_format!
    verify_content_type_header!
    verify_accept_header!
  end

  def verify_accept_header!
    return if request.headers["Accept"] == "application/json"

    raise BadRequestHeaderError, 'Request Accept header has to be: application/json'
  end

  def verify_content_type_header!
    return if request.headers["Content-Type"] == "application/json"

    raise BadRequestHeaderError, 'Request Content-Type header has to be: application/json'
  end

  def verify_authorization_header!
    return if request.headers["Authorization"].present?

    raise BadRequestHeaderError, 'Request Authorisation header is missing'
  end

  def bad_request_header_error(exception)
    respond_with_errors errors: exception.message, status: :bad_request
  end

  def unauthorized_error(_exception)
    respond_with_errors errors: 'Unauthorized', status: :unauthorized
  end

  def request_header(header)
    request.header[header]
  end

  def respond_with(record, serializer:, **kwargs)
    if record.respond_to?(:errors) && record.errors.present?
      respond_with_errors errors: record.errors.full_messages, status: :unprocessable_entity
    else
      render json: serializer.render(record), status: kwargs.fetch(:status, :ok)
    end
  end

  def respond_with_errors(errors:, status:)
    render json: { errors: errors }.to_json, status: status
  end

  def record_not_found
    respond_with_errors errors: "Record not found", status: :not_found
  end
end


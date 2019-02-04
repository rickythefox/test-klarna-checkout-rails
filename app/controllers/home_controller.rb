class HomeController < ApplicationController
  def index
    @html_snippet = KlarnaService.new.create_order
  end

  def confirm
    @html_snippet = KlarnaService.new.get_and_ack_order request.query_parameters['sid']
  end
end

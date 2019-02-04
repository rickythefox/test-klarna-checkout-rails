require 'httparty'

class KlarnaService
  def initialize
    @endpoint_base = Rails.application.config.x.klarna.endpoint_base
    @username = Rails.application.credentials.klarna[:username]
    @password = Rails.application.credentials.klarna[:password]
  end

  def create_order
    response = HTTParty.post("#{@endpoint_base}/checkout/v3/orders",
                             basic_auth: {username: @username, password: @password},
                             headers: {'Content-Type' => 'application/json'},
                             format: :json,
                             body: create_order_body.to_json
    )
    response['html_snippet']
  end

  def get_and_ack_order id
    ack_order id
    response = HTTParty.get("#{@endpoint_base}/checkout/v3/orders/#{id}",
                            basic_auth: {username: @username, password: @password},
                            format: :json
    )
    response['html_snippet']
  end

  def ack_order id
    response = HTTParty.post("#{@endpoint_base}/ordermanagement/v1/orders/#{id}/acknowledge",
                             basic_auth: {username: @username, password: @password},
                             headers: {'Content-Type' => 'application/json'},
                             format: :json,
    )
    puts response.to_s
  end

  private

  def create_order_body
    {
        purchase_country: 'gb',
        purchase_currency: 'gbp',
        locale: 'en-GB',
        order_amount: 10000,
        order_tax_amount: 0,
        order_lines: [
            {
                type: 'physical',
                reference: 'molds',
                name: 'Dental molds',
                quantity: 1,
                quantity_unit: 'pcs',
                unit_price: 10000,
                tax_rate: 0,
                total_amount: 10000,
                total_discount_amount: 0,
                total_tax_amount: 0,
                product_url: 'https://www.estore.com/products/f2a8d7e34',
                image_url: 'https://www.exampleobjects.com/logo.png'
            }
        ],
        merchant_urls: {
            terms: 'https://www.estore.com/terms.html',
            checkout: 'https://local.dev:3000?sid={checkout.order.id}',
            confirmation: 'https://local.dev:3000/confirm?sid={checkout.order.id}',
            push: 'https://www.estore.com/api/push?checkout_uri={checkout.order.id}',
            #address_update: 'https://local.dev/address_update'
        },
        options: {
            allowed_customer_types: ['person'],
            acquiring_channel: 'eCommerce',
            allow_separate_shipping_address: false,
            color_button: '#FF9900',
            color_button_text: '#FF9900',
            color_checkbox: '#FF9900',
            color_checkbox_checkmark: '#FF9900',
            color_header: '#FF9900',
            color_link: '#FF9900',
            date_of_birth_mandatory: false,
            shipping_details: 'Delivered within 1-3 working days',
            title_mandatory: false,
            additional_checkbox: {
                text: 'I agree!',
                checked: false,
                required: true
            },
            national_identification_number_mandatory: false,
            additional_merchant_terms: 'string',
            radius_border: '5',
            show_subtotal_detail: false,
            require_validate_callback_success: false,
            vat_removed: false
        },
        shipping_countries: [
            'gb'
        ],
        shipping_options: [
            {
                id: 'express_priority',
                name: 'EXPRESS 1-2 Days',
                price: 0,
                tax_amount: 0,
                tax_rate: 0,
            }
        ],
        gui: {
            options: [
                'disable_autofocus'
            ]
        },
        recurring: false,
        billing_countries: [
            'gb'
        ]
    }
  end
end
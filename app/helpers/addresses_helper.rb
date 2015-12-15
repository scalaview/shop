module AddressesHelper

  def full_address(address)
    attributes = %w{ province city area location street }
    attributes.map do |att|
      address[att]
    end
  end
end

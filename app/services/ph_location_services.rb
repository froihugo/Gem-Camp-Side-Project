class PhLocationServices
  attr_reader :url

  def initialize
    @url = 'https://psgc.gitlab.io/api'
  end

  def fetch_region
    request = RestClient.get("#{url}/regions/")
    data = JSON.parse(request.body)
    data.each do |region|
      address_region = Address::Region.find_or_initialize_by(code: region['code'])
      address_region.name = region['regionName']
      address_region.save
    end
  end

  def fetch_province
    request = RestClient.get("#{url}/provinces")
    data = JSON.parse(request.body)

    data.each do |province|
      address_province = Address::Province.find_or_initialize_by(code: province['code'])
      region = Address::Region.find_by_code(province['regionCode'])
      address_province.region = region
      address_province.name = province['name']
      address_province.save
    end
    request = RestClient.get("#{url}/districts")
    data = JSON.parse(request.body)
    data.each do |district|
      address_districts = Address::Province.find_or_initialize_by(code: district['code'])
      region = Address::Region.find_by_code(district['regionCode'])
      address_districts.region = region
      address_districts.name = district['name']
      address_districts.save
    end
  end

  def fetch_city
    request = RestClient.get("#{url}/cities-municipalities")
    data = JSON.parse(request.body)
    data.each do |city|
      address_city = Address::City.find_or_initialize_by(code: city['code'])
      if city['districtCode'].present?
        province = Address::Province.find_by(code: city['districtCode'])
        Address::City.find_or_create_by(code: city['code'], name: city['name'], province: province)
        address_city.save
      elsif city['provinceCode'].present?
        province = Address::Province.find_by(code: city['provinceCode'])
        Address::City.find_or_create_by(code: city['code'], name: city['name'], province: province)
        address_city.save
      else
        if city['name'] == "City of Isabela"
          province = Address::Province.find_by_name('Basilan')
          Address::City.find_or_create_by(code: city['code'], name: city['name'], province: province)
          address_city.save
        elsif city['name'] == "City of Cotabato"
          province = Address::Province.find_by_name('Maguindanao')
          Address::City.find_or_create_by(code: city['code'], name: city['name'], province: province)
          address_city.save
        end
      end
    end
  end

  def fetch_barangay
    request = RestClient.get("#{url}/barangays/")
    data = JSON.parse(request.body)
    data.each do |barangay|
      if barangay['cityCode']
        address_city = Address::City.find_by(code: barangay['cityCode'])
        address_barangay = Address::Barangay.find_or_initialize_by(code: barangay['code'])
        address_barangay.name = barangay['name']
        address_barangay.city = address_city
        address_barangay.save
      else
        address_city = Address::City.find_by(code: barangay['municipalityCode'])
        address_barangay = Address::Barangay.find_or_initialize_by(code: barangay['code'])
        address_barangay.name = barangay['name']
        address_barangay.city = address_city
        address_barangay.save
      end
    end
  end
end

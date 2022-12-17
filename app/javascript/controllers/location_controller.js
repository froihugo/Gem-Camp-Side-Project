import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectRegionId", "selectProvinceId","selectCityId","selectBarangayId"]

  fetchProvinces() {
    let target = this.selectProvinceIdTarget
    $(target).empty();
    $.ajax({
      type: 'GET',
      url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces',
      dataType: 'json',
      success: (response) => {
        console.log(response)
        let option = document.createElement('option')
        option.value = ''
        option.text = 'SELECT PROVINCE/DISTRICT'
      target.appendChild(option)
        $.each(response, function (index, record) {
          let option = document.createElement('option')
          option.value = record.id
          option.text = record.name
          target.appendChild(option)
        })
      }
    })
  }

  fetchCities() {
    let target = this.selectCityIdTarget
    $(target).empty();
    $.ajax({
      type: 'GET',
      url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces/' + this.selectProvinceIdTarget.value + '/city_municipalities',
      dataType: 'json',
      success: (response) => {
        console.log(response)
        let option = document.createElement('option')
        option.value = ''
        option.text = 'SELECT CITY/MUNICIPALITY'
        target.appendChild(option)
        $.each(response, function (index, record) {
          let option = document.createElement('option')
          option.value = record.id
          option.text = record.name
          target.appendChild(option)
        })
      }
    })
  }

  fetchBarangays() {
    let target = this.selectBarangayIdTarget
    $(target).empty();
    $.ajax({
      type: 'GET',
      url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces/' + this.selectProvinceIdTarget.value + '/city_municipalities/' + this.selectCityMunicipalityIdTarget.value + '/barangays',
      dataType: 'json',
      success: (response) => {
        console.log(response)
        let option = document.createElement('option')
        option.value = ''
        option.text = 'SELECT BARANGAY'
        target.appendChild(option)
        $.each(response, function (index, record) {
          let option = document.createElement('option')
          option.value = record.id
          option.text = record.name
          target.appendChild(option)
          })
      }
    })
  }
}
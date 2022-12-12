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
        $.each(response, function (index, record) {
          console.log(record.name)
          console.log(record.id)
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
        url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces/' + this.selectProvinceIdTarget.value + '/cities',
        dataType: 'json',
        success: (response) => {
          $.each(response, function (index, record) {
            console.log(record.name)
            console.log(record.id)
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
            url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces/' + this.selectProvinceIdTarget.value + '/cities/' + this.selectCityIdTarget.value + '/barangays',
            dataType: 'json',
            success: (response) => {
              $.each(response, function (index, record) {
                console.log(record.name)
                console.log(record.id)
                let option = document.createElement('option')
                option.value = record.id
                option.text = record.name
                target.appendChild(option)
              })
            }
          })
        }

}
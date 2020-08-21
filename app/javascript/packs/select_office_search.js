let floor = document.getElementById('floor_id')
let officeDiv = document.getElementById('office-select')

floor.addEventListener('change', () => {
  officeDiv.innerHTML = ''
  if(floor.value != 0){
    fetch(`/floor_offices/${floor.value}`)
    .then(response => response.json())
    .then(data => {
      data.forEach(office => {
          let opt = document.createElement('option')
          opt.value = office.id;
          opt.innerHTML = office.name
          officeDiv.appendChild(opt)
        })
      });
  }
})
let floor = document.getElementById('visit_floor_id')
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


//Search visitor
let searchDni = document.getElementById('searchDni')
let btnSearch = document.getElementById('btnSearch')

//visitor table data
let tdId = document.getElementById('tdId')
let tdPhotoText = document.getElementById('tdPhotoText')
let tdPhoto = document.getElementById('tdPhoto')
let tdDni = document.getElementById('tdDni')
let tdFullname = document.getElementById('tdFullname')
let tdOptions = document.getElementById('tdOptions')
let btn = document.createElement('button')
btn.innerText = 'Seleccionar'
btn.id = 'btnAdd'
btn.classList.add('btn')
btn.classList.add('btn-info')

btnSearch.addEventListener('click', () => {
  if(searchDni.value != ""){
    btnSearch.disabled = true;
    fetch(`/search_visitor/${searchDni.value}`)
    .then(response => response.json())
    .then(data => {
      if(data.length != 0){
        data.forEach(visitor => {
          tdId.innerText = visitor.id
          console.log(visitor.photo)
          if(visitor.photo == ""){
            tdPhotoText.innerText = "No tiene foto"
          }else{
            tdPhotoText.innerText = ""
            let photo = document.createElement('img')
            photo.src = visitor.photo
            photo.style.width = "10rem"
            tdPhotoText.appendChild(photo)
          }

          tdDni.innerText = visitor.dni;
          tdDni.style.verticalAlign = "middle"
          tdFullname.innerText = `${visitor.first_name} ${visitor.last_name}`;
          tdFullname.style.verticalAlign = "middle"
          tdOptions.appendChild(btn)
          tdOptions.style.verticalAlign = "middle"
        })
      }else{
        tdDni.innerText = "No esta registrado";
        tdFullname.innerText = "";
        tdOptions.innerText = "";
      }
    }); 
    btnSearch.disabled = false;
    
  }else{
    tdDni.innerText = "";
    tdFullname.innerText = "";
    tdOptions.innerText = "";
  }
})

// Set dni and full name to the visit form
let idField = document.getElementById('visit_visitor_id')
let dniField = document.getElementById('visit_visitor_dni')
let fullnameField = document.getElementById('visit_full_name')

btn.addEventListener('click', () => {
  idField.value = tdId.innerText;
  dniField.value = tdDni.innerText;
  fullnameField.value = tdFullname.innerText;
})







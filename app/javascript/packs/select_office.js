//Select office
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
let visitorsTable = document.getElementById('visitorsTable').getElementsByTagName('tbody')[0];

btnSearch.addEventListener('click', () => {
  visitorsTable.innerHTML = "";

  if(searchDni.value != ""){
    btnSearch.disabled = true;
    fetch(`/search_visitor/${searchDni.value}`)
    .then(response => response.json())
    .then(data => {
      if(data.length != 0){

        data.forEach(visitor => {

          let newTr = visitorsTable.insertRow();

          //TD for photo
          let tdId = newTr.insertCell(0);
          if(visitor.photo != ""){
            let img = document.createElement('img');
            img.src = visitor.photo;
            img.style.width = "10rem"
            tdId.appendChild(img)
          }else{
            tdId.innerHTML = "No tiene foto"
          }
          tdId.style.verticalAlign = "middle"

          //TD for dni
          let tdDni = newTr.insertCell(1);
          tdDni.innerHTML = visitor.dni;
          tdDni.style.verticalAlign = "middle"

          //TD for fullname
          let tdName = newTr.insertCell(2);
          tdName.innerHTML = `${visitor.first_name} ${visitor.last_name}`;
          tdName.style.verticalAlign = "middle"
          
          //TD for company
          let tdCompany = newTr.insertCell(3);
          tdCompany.innerHTML = visitor.company;
          tdCompany.style.verticalAlign = "middle"

          let tdOpt = newTr.insertCell(4);
          tdOpt.style.verticalAlign = "middle"
          let btn = document.createElement('button');
          btn.innerText = 'Seleccionar'
          btn.classList.add('btn')
          btn.classList.add('btn-info')
          btn.addEventListener('click', function setVisitorData(){
            console.log('-------------------')
            console.log(visitor.dni)
            idField.value = visitor.id;
            dniField.value = visitor.dni;
            fullnameField.value = tdName.innerText;
            companyField.value = visitor.company;
          })

          tdOpt.appendChild(btn)
        })
      }else{
        let newTr2 = visitorsTable.insertRow();
        let field = newTr2.insertCell(0);
        field.innerHTML = "No se han encontrado registos";
        field.colSpan = "5"
      }
    }); 
    btnSearch.disabled = false;
    
  }else{
    let newTr3 = visitorsTable.insertRow();
    let field2 = newTr3.insertCell(0);
    field2.innerHTML = "Debes ingresar algun dato en la caja para realizar la busqueda";
    field2.colSpan = "5"
  }
})


// Set dni and full name to the visit form
let idField = document.getElementById('visit_visitor_id')
let dniField = document.getElementById('visit_visitor_dni')
let fullnameField = document.getElementById('visit_full_name')
let companyField = document.getElementById('visit_company')







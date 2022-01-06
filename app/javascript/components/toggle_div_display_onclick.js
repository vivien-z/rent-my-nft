const toggleDivDisplayOnclick = () => {
  const btns = document.getElementsByClassName('toggle-btn')
  
  if (btns) {
    for (let i = 0; i < btns.length; i++) {
      const btn = btns[i]
      const divId = btn.dataset.toggle
      const div = document.getElementById(divId)
     
      btn.addEventListener('click', (e) => {
        e.preventDefault()
   
        div.style.display === "block" ?  div.style.display = 'none' : div.style.display = 'block';
      } )
    }
   
   
  }
}

export { toggleDivDisplayOnclick };
const toggleDivDisplayOnclick = () => {
  const btns = document.getElementsByClassName('toggle-btn')
  
  if (btns) {
    for (let i = 0; i < btns.length; i++) {
      const btn = btns[i]
      const divId = btn.dataset.toggle
      const div = document.getElementById(divId)
     
      btn.addEventListener('click', (e) => {
        div.style.display === "block" ?  div.style.display = 'none' : div.style.display = 'block';
        if (divId === "map") {
          const nfts = document.getElementById('nft-list')
          nfts.classList.contains("fullsize") ? nfts.classList.remove("fullsize") : nfts.classList.add("fullsize")
        }
      })
    }
  }
}

export { toggleDivDisplayOnclick };
function calculation (){
  const itemPrice = document.getElementById("item-price")
  const itemTax = document.getElementById("add-tax-price") 
  const itemProfit = document.getElementById("profit")
  itemPrice.addEventListener ('keyup', () => {
    let price = itemPrice.value
    let tax = Math.floor( price * 0.1 )
    let profit = Math.floor( price * 0.9 )
    itemTax.innerHTML = tax
    itemProfit.innerHTML = profit
  })
}

window.addEventListener('load', calculation)
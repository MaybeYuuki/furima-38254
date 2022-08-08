function price() {
  const priceInput = document.getElementById("item-price");
  const add_tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  priceInput.addEventListener("keyup", () => {
    const value = priceInput.value;

    if (value >= 300 && value <= 9999999) {
      add_tax.innerHTML = Math.floor(value * 0.1);
      profit.innerHTML = Math.floor(value - (value * 0.1));
    } else {
      add_tax.innerHTML = "";
      profit.innerHTML = "";
    }
  });
}
window.addEventListener("load", price);
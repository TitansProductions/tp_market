let selectedCost = 0;
let selectedCostResult = 0;
let selectedItem = false;

let selectedItemPaymentType = "cash";
let selectedPaymentItemName = "";
let selectedItemGivenAmount = 0;

let selectedItemType, selectedItemName, selectedItemLabel = "";

function closeMarket() {
	toggleSupermarket(false)

	selectedCost = 0;
	selectedCostResult = 0;
	selectedItem = false;
	selectedItemType = "";
	selectedItemName = "";
	selectedItemLabel = "";

	selectedItemPaymentType = "cash";
	selectedPaymentItemName = "";

	selectedItemGivenAmount = 0;

	document.getElementById("displayed_product_description_title").innerHTML = '';
	document.getElementById("displayed_product_description").innerHTML = '';
	document.getElementById("displayed_product_purchase_title").innerHTML = '';
	document.getElementById("displayed_product_purchase_cost").innerHTML = '';
	document.getElementById("product_count_total_cost").innerHTML = '';
	document.getElementById("product_accepted_payment_types").innerHTML = '';
	document.getElementById('product_count').value = "1";

	$.post('http://tp-market/closeUI', JSON.stringify({}));
}

const loadScript = (FILE_URL, async = true, type = "text/javascript") => {
    return new Promise((resolve, reject) => {
        try {
            const scriptEle = document.createElement("script");
            scriptEle.type = type;
            scriptEle.async = async;
            scriptEle.src =FILE_URL;

            scriptEle.addEventListener("load", (ev) => {
                resolve({ status: true });
            });

            scriptEle.addEventListener("error", (ev) => {
                reject({
                    status: false,
                    message: `Failed to load the script ${FILE_URL}`
                });
            });

            document.body.appendChild(scriptEle);
        } catch (error) {
            reject(error);
        }
    });
};

loadScript("js/locales/locales-" + Config.Locale + ".js").then( data  => { 
	console.log("Successfully loaded " + Config.Locale + " locale file.", data); 

	document.getElementById("product_buy").innerHTML = Locales.product_buy_button;
	
}) .catch( err => { console.error(err); });

function getItemIMG(item){
    return 'nui://tp-base/html/img/items/' + item + '.png';
}

function toggleSupermarket(bool) {

	if (bool) {
		$("#supermarket").show();
	} else {
		$("#supermarket").hide();
	}
}

// Updating Total Cost when input text is changing.

const source = document.getElementById('product_count');
const result = document.getElementById('product_count_total_cost');

const inputHandler = function(e) {

	
	if (!selectedItem && e.target.value != 1){
		document.getElementById('product_count').value = "1";
	}

	if (selectedItem) {
		if (selectedItemType == "weapon") {
			document.getElementById('product_count').value = "1";
			result.innerHTML = Locales.total_cost + Locales.currency_symbol + selectedCost;
			selectedCostResult = selectedCost;
		}

		else if (e.target.value < 0 || e.target.value == null || e.target.value == undefined || isNaN(e.target.value)){
			document.getElementById('product_count').value = "1";
			result.innerHTML = Locales.total_cost + Locales.currency_symbol + 1 * selectedCost;
			selectedCostResult = selectedCost;

			$.post('http://tp-market/sendNotification', JSON.stringify({ message : "invalid_amount" }))

		}else{
			result.innerHTML = Locales.total_cost + Locales.currency_symbol + e.target.value * selectedCost;
			selectedCostResult = e.target.value * selectedCost;
		}
	}
}

source.addEventListener('input', inputHandler);
// --------------------------------------------------

$(function () {

    toggleSupermarket(false)

    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.action === 'toggle') {
			toggleSupermarket(item.toggle)
		}

		else if (item.action === 'addMarketTitle'){
			$("#products").html('');
			document.getElementById("supermarket_type_title").innerHTML = '<span id="super_type_style">'+item.type.toUpperCase();
		
		}else if (item.action === 'addProduct'){
			var prod_item = item.products_det

			$("#products").append(
				`<div id="product_main">`+
				`<div id="product_det">`+
				   `<img src= "`+ getItemIMG(prod_item.item) +`" id="product_img">`+

					`<span id="product_label"> `+prod_item.label+` </span>`+

					`<div id="product_checkout" givenAmount = "` + prod_item.amount + `" paymentType = "` + prod_item.paymentType + `" paymentItemName = "` + prod_item.paymentItem + `" item = `+ prod_item.item+` price=`+prod_item.price+` item_type=`+prod_item.type+` supermarket_type=`+item.type+` label = "` + prod_item.label + `" description = "` + prod_item.description + `" >`+
					Locales.checkout_button +
					`</div>`+
				`</div>`
			);
			
	
		}
    });

	// On Market Close.
	$("body").on("keyup", function (key) {
		if (key.which == 27){
			closeMarket();
		}
	});

	// On Product Checkout
	$("#products").on("click", "#product_checkout", function() {

        var $button = $(this);
        var $price = $button.attr('price');

		var $itemLabel = $button.attr('label');
		var $description = $button.attr('description');
		var $givenItemAmount = $button.attr('givenAmount');

		// Product Description & Information Display.
		document.getElementById("displayed_product_description_title").innerHTML = $itemLabel + Locales.description;
		document.getElementById("displayed_product_description").innerHTML = $description;

		document.getElementById("displayed_product_purchase_title").innerHTML = Locales.purchase_information;

		document.getElementById("displayed_product_purchase_cost").innerHTML = Locales.given_amount + "<span style = 'color: rgb(73, 184, 129);'> X" + $givenItemAmount + "</span> <br />" + Locales.cost_is + "<span style = 'color: rgb(73, 184, 129);'>" + Locales.currency_symbol + $price + "</span>";
		
		// Displaying the payment type.
		var $currency = $button.attr('paymentType');
		var $paymentItemName = $button.attr('paymentItemName');

		document.getElementById("product_accepted_payment_types").innerHTML = '<i class="fas fa-wallet"> ‍Wallet </i> ‍ ‍ ‍ ‍<i class="fas fa-credit-card"> ‍Credit Card</i> ‍ ‍ ‍ ‍<i class="fas fa-money-bill"> ‍Black (Dirty) Money</i>';

		if ($currency == "money"){
			document.getElementById("product_accepted_payment_types").innerHTML = '<span style = "color: rgb(34,139,34);"<i class="fas fa-wallet"> ‍Wallet </i></span> ‍ ‍ ‍ ‍<i class="fas fa-credit-card"> ‍Credit Card</i> ‍ ‍ ‍ ‍<i class="fas fa-money-bill"> ‍Black (Dirty) Money</i>';
		}
		else if ($currency == "bank") {
			document.getElementById("product_accepted_payment_types").innerHTML = '<i class="fas fa-wallet"> ‍Wallet </i> ‍ ‍ ‍ ‍<span style = "color: rgb(34,139,34);"<i class="fas fa-credit-card"> ‍Credit Card</i></span> ‍ ‍ ‍ ‍<i class="fas fa-money-bill"> ‍Black (Dirty) Money</i>';
		}

		else if ($currency == "black_money") {
			document.getElementById("product_accepted_payment_types").innerHTML = '<i class="fas fa-wallet"> ‍Wallet </i> ‍ ‍ ‍ ‍<i class="fas fa-credit-card"> ‍Credit Card</i> ‍ ‍ ‍ ‍<span style = "color: rgb(34,139,34);"<i class="fas fa-money-bill"> ‍Black (Dirty) Money</i></span>';
		}
		else if ($currency == 'item' && ($paymentItemName == "cash" || $paymentItemName == "money" || $paymentItemName == "wallet")){
			document.getElementById("product_accepted_payment_types").innerHTML = '<span style = "color: rgb(34,139,34);"<i class="fas fa-wallet"> ‍Wallet </i></span> ‍ ‍ ‍ ‍<i class="fas fa-credit-card"> ‍Credit Card</i> ‍ ‍ ‍ ‍<i class="fas fa-money-bill"> ‍Black (Dirty) Money</i>';
		}
		else if ($currency == 'item' && ($paymentItemName == "blackmoney" || $paymentItemName == "black_money" || $paymentItemName == "dirtymoney" || $paymentItemName == "dirty_money")){
			document.getElementById("product_accepted_payment_types").innerHTML = '<i class="fas fa-wallet"> ‍Wallet </i> ‍ ‍ ‍ ‍<i class="fas fa-credit-card"> ‍Credit Card</i> ‍ ‍ ‍ ‍<span style = "color: rgb(34,139,34);"<i class="fas fa-money-bill"> ‍Black (Dirty) Money</i></span>';
		}

		// Total Cost & Count Display.
		document.getElementById('product_count_total_cost').innerHTML = Locales.total_cost + Locales.currency_symbol + $price;
		document.getElementById('product_count').value = "1";

		selectedItem = true;
		selectedCost = $price;
		selectedCostResult = $price;

		// Getting Item Type (Weapon, Item, etc.).
		var $item_type = $button.attr('item_type');
		selectedItemType = $item_type;

		// Getting Item Name.
		var $item = $button.attr('item');
		selectedItemName = $item;

		// Getting Payment Currency Type.
		selectedItemPaymentType = $currency;

		// Getting Item Label.
		selectedItemLabel = $itemLabel;

		// Getting item name if payment type is item.
		selectedPaymentItemName = $paymentItemName;

		// Getting the given amount of the purchased item.
		selectedItemGivenAmount = $givenItemAmount;

		return
	});

	// On Product Purchase.
	$("#bottom-right-side").on("click", "#product_buy", function() {

		if (selectedItem){
			var purchaseAmount = document.getElementById('product_count').value;

			if (purchaseAmount <= 0){
				$.post('http://tp-market/sendNotification', JSON.stringify({ message : "invalid_amount" }))
				return;
			}

			var purchaseItemName = selectedItemName;
			var purchaseCost   = selectedCostResult;
			var purchasePaymentType = selectedItemPaymentType;
			var purchaseItemType = selectedItemType;
			var purchasePaymentItemName = selectedPaymentItemName;

			$.post('http://tp-market/buyProduct', JSON.stringify({
				item : purchaseItemName,
				label : selectedItemLabel,
				amount : purchaseAmount,
				givenAmount : selectedItemGivenAmount,
				price : purchaseCost,
				currency : purchasePaymentType,
				itemType : purchaseItemType,
				currencyItemName : purchasePaymentItemName,
			}));

		}
	});

})
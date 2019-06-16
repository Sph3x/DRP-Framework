const ShopUIApp = new Vue({
  el: "#ISRP_Shop_UI",

  data: {
    showShopMenu: false
  },

  methods: {
    ///////////////////////////////////////////////////////////////////////////
    // GARAGES
    ///////////////////////////////////////////////////////////////////////////
    OpenShop() {
      this.showShopMenu = true;
    },

    CloseShop() {
      this.showShopMenu = false;
      axios
        .post("http://drp_shops/close_shop", {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    PurchaseBandage() {
      axios
        .post("http://drp_shops/purchase_bandage", {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    PurchaseRepairKit() {
      axios
        .post("http://drp_shops/purchase_repairkit", {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },

    PurchaseLockPick() {
      axios
        .post("http://drp_shops/purchase_lockpick", {})
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
});

// Listener from Lua CL
document.onreadystatechange = () => {
  if (document.readyState == "complete") {
    window.addEventListener("message", event => {
      if (event.data.type == "open_shop_menu") {
        ShopUIApp.OpenShop();
      }
    });
  }
};

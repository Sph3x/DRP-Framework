const PoliceMenu = new Vue({
  el: "#DRP_PoliceMenu",

  data: {
    showPoliceMenu: false
  },

  methods: {
    ///////////////////////////////////////////////////////////////////////////
    // Bus Route
    ///////////////////////////////////////////////////////////////////////////
    OpenPoliceMenu() {
      this.showPoliceMenu = true;
    },

    Cuff() {
      this.showPoliceMenu = false;
      axios.post("http://drp_police/handcuff", {}).catch(error => {
        console.log(error);
      });
    },

    Escort() {
      this.showPoliceMenu = false;
      axios.post("http://drp_police/drag", {}).catch(error => {
        console.log(error);
      });
    },

    Fine() {
      this.showPoliceMenu = false;
      axios.post("http://drp_police/fine", {}).catch(error => {
        console.log(error);
      });
    },

    Search() {
      this.showPoliceMenu = false;
      axios.post("http://drp_police/search", {}).catch(error => {
        console.log(error);
      });
    },

    ClosePoliceMenu() {
      this.showPoliceMenu = false;
      axios.post("http://drp_police/closeJobCenter", {}).catch(error => {
        console.log(error);
      });
    }
  }
});

// Listener from Lua CL
document.onreadystatechange = () => {
  if (document.readyState == "complete") {
    window.addEventListener("message", event => {
      if (event.data.type == "open_police_menu") {
        PoliceMenu.OpenPoliceMenu();
      }
    });
  }
};

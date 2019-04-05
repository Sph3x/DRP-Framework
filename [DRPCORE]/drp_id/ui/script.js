const DRP_Characters = new Vue({
    el: "#DRP_Characters",

    data: {

        // Shared
        ResourceName: "drp_id",
        showCharacterSelector: false,
        showCharacterCreator: false,
        showCharacterDelete: false,

        // Character Selector
        characters: [],

        // Character Creator
        genders: ["Male", "Female"],

        selectedFirstname: "",
        selectedLastname: "",
        selectedGender: "",
        selectedAge: "",
        selectedDeleteCharacter: "",
    },

    methods: {

        // START OF MAIN MENU
        OpenCharactersMenu(characters) {
            this.showCharacterSelector = true;
            this.characters = characters;
        },

        CloseCharactersMenu() {
            axios.post(`http://${this.ResourceName}/CloseMenu`, {}).then((response) => {
                this.showCharacterCreator = false;
                this.showCharacterSelector = false;
            }).catch((error) => { });
        },

        UpdateCharacters(characters) {
            console.log(characters);
            this.characters = characters;
            if (this.showCharacterCreator == false) {
                this.FormReset();
            }
        },

        CreateCharacter() {
            axios.post(`http://${this.ResourceName}/CreateCharacter`, {
                name: `${FixName(this.selectedFirstname)} ${FixName(this.selectedLastname)}`,
                age: this.selectedAge,
                gender: this.selectedGender
            }).then((response) => {
                this.showCharacterCreator = false;
            }).catch((error) => { });
        },

        SelectCharacter(index) {
            console.log(`CHARACTER ID: ${this.characters[index].id}`);
            this.showCharacterSelector = false;
            var character_info = this.characters[index].id
            axios.post(`http://${this.ResourceName}/SelectYourCharacter`, {
                character_selected: character_info
            }).then((response) => { }).catch((error) => { });
        },

        RequestDeleteCharacter(index) {
            this.selectedDeleteCharacter = index;
            this.showCharacterDelete = true;
        },

        DeleteCharacter() {
            this.showCharacterDelete = false;
            var chosen_character = this.characters[this.selectedDeleteCharacter].id
            axios.post(`http://${this.ResourceName}/DeleteCharacter`, {
                character_id: chosen_character
            }).then((response) => { }).catch((error) => { });
        },

        FinishCharacter() {
            if (this.model != "") {
                this.showCharacterModifier = false;
                axios.post(`http://${this.ResourceName}/finishcharactercreator`, {
                    model: this.model
                }).then((response) => {
                    console.log(response);
                }).catch((error) => {
                    console.log(error);
                })
            }
        },

        FormReset() {
            this.$refs.DRPCreatorForm.reset();
            this.selectedAge = 0
        },
    },
});

function FixName(name) {
    var newName = ""
    for (var a = 0; a < name.length; a++) {
        if (a == 0) {
            newName = name[a].toUpperCase();
        } else {
            var concat = newName + name[a].toLowerCase();
            newName = concat;
        }
    }
    return newName
}

// Listener from Lua CL
document.onreadystatechange = () => {
    if (document.readyState == "complete") {
        window.addEventListener("message", (event) => {

            ///////////////////////////////////////////////////////////////////////////
            // Character Main Menu
            ///////////////////////////////////////////////////////////////////////////

            if (event.data.type == "open_character_menu") {

                DRP_Characters.OpenCharactersMenu(event.data.characters);

            } else if (event.data.type == "update_character_menu") {

                DRP_Characters.UpdateCharacters(event.data.characters);

            }
        });
    }
}

Jaml.register("abilities", function(character) {
  dl({ cls: "abilities" },
    dt({ cls: "str" }, "Str"),
    dd({ cls: "str" }, character.abilities.strength.toString()),
    dd({ cls: "str mod" }, character.abilities.strength.modifier().toSignedString() + "/" + (character.abilities.strength.modifier() + character.halfLevel()).toSignedString()),
    dt({ cls: "con" }, "Con"),
    dd({ cls: "con" }, character.abilities.constitution.toString()),
    dd({ cls: "con mod" }, character.abilities.constitution.modifier().toSignedString() + "/" + (character.abilities.constitution.modifier() + character.halfLevel()).toSignedString()),
    dt({ cls: "dex" }, "Dex"),
    dd({ cls: "dex" }, character.abilities.dexterity.toString()),
    dd({ cls: "dex mod" }, character.abilities.dexterity.modifier().toSignedString() + "/" + (character.abilities.dexterity.modifier() + character.halfLevel()).toSignedString()),
    dt({ cls: "int" }, "Int"),
    dd({ cls: "int" }, character.abilities.intelligence.toString()),
    dd({ cls: "int mod" }, character.abilities.intelligence.modifier().toSignedString() + "/" + (character.abilities.intelligence.modifier() + character.halfLevel()).toSignedString()),
    dt({ cls: "wis" }, "Wis"),
    dd({ cls: "wis" }, character.abilities.wisdom.toString()),
    dd({ cls: "wis mod" }, character.abilities.wisdom.modifier().toSignedString() + "/" + (character.abilities.wisdom.modifier() + character.halfLevel()).toSignedString()),
    dt({ cls: "cha" }, "Cha"),
    dd({ cls: "cha" }, character.abilities.charisma.toString()),
    dd({ cls: "cha mod" }, character.abilities.charisma.modifier().toSignedString() + "/" + (character.abilities.charisma.modifier() + character.halfLevel()).toSignedString())
  ),
  dl({ cls: "defenses" },
    dt({ cls: "fort" }, "Fort"),
    dd({ cls: "fort" }, character.defenses.fortitude.toString()),
    dt({ cls: "ref" }, "Ref"),
    dd({ cls: "ref" }, character.defenses.reflex.toString()),
    dt({ cls: "will" }, "Will"),
    dd({ cls: "will" }, character.defenses.will.toString()),
    dt({ cls: "ac" }, "AC"),
    dd({ cls: "ac" }, character.defenses.ac.toString())
  )
});


Jaml.register("abilities", function(character) {
  dl({ cls: "abilities" },
    dt({ cls: "str" }, "Str"),
    dd({ cls: "str" }, character.abilities.strength.toString()),
    dd({ cls: "str mod" }, character.abilities.strength.modifier().toSignedString()),
    dt({ cls: "con" }, "Con"),
    dd({ cls: "con" }, character.abilities.constitution.toString()),
    dd({ cls: "con mod" }, character.abilities.constitution.modifier().toSignedString()),
    dt({ cls: "dex" }, "Dex"),
    dd({ cls: "dex" }, character.abilities.dexterity.toString()),
    dd({ cls: "dex mod" }, character.abilities.dexterity.modifier().toSignedString()),
    dt({ cls: "int" }, "Int"),
    dd({ cls: "int" }, character.abilities.intelligence.toString()),
    dd({ cls: "int mod" }, character.abilities.intelligence.modifier().toSignedString()),
    dt({ cls: "wis" }, "Wis"),
    dd({ cls: "wis" }, character.abilities.wisdom.toString()),
    dd({ cls: "wis mod" }, character.abilities.wisdom.modifier().toSignedString()),
    dt({ cls: "cha" }, "Cha"),
    dd({ cls: "cha" }, character.abilities.charisma.toString()),
    dd({ cls: "cha mod" }, character.abilities.charisma.modifier().toSignedString())
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


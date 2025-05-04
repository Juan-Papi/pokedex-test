class PokemonDetail {
  final List<Ability> abilities;
  final int baseExperience;
  final Cries cries;
  final List<Species> forms;
  final List<GameIndex> gameIndices;
  final int height;
  final List<dynamic> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final List<PastAbility> pastAbilities;
  final List<dynamic> pastTypes;
  final Species species;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  PokemonDetail({
    required this.abilities,
    required this.baseExperience,
    required this.cries,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastAbilities,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        abilities: (json["abilities"] as List<dynamic>?)
                ?.map((x) => Ability.fromJson(x))
                .toList() ??
            [],
        baseExperience: json["base_experience"] ?? 0,
        cries: json["cries"] != null ? Cries.fromJson(json["cries"]) : Cries(latest: '', legacy: ''),
        forms: (json["forms"] as List<dynamic>?)
                ?.map((x) => Species.fromJson(x))
                .toList() ??
            [],
        gameIndices: (json["game_indices"] as List<dynamic>?)
                ?.map((x) => GameIndex.fromJson(x))
                .toList() ??
            [],
        height: json["height"] ?? 0,
        heldItems: json["held_items"] as List<dynamic>? ?? [],
        id: json["id"] ?? 0,
        isDefault: json["is_default"] ?? false,
        locationAreaEncounters: json["location_area_encounters"] ?? '',
        moves: (json["moves"] as List<dynamic>?)
                ?.map((x) => Move.fromJson(x))
                .toList() ??
            [],
        name: json["name"] ?? '',
        order: json["order"] ?? 0,
        pastAbilities: (json["past_abilities"] as List<dynamic>?)
                ?.map((x) => PastAbility.fromJson(x))
                .toList() ??
            [],
        pastTypes: json["past_types"] as List<dynamic>? ?? [],
        species: json["species"] != null
            ? Species.fromJson(json["species"])
            : Species(name: '', url: ''),
        sprites: json["sprites"] != null
            ? Sprites.fromJson(json["sprites"])
            : Sprites(
                backDefault: '',
                backFemale: null,
                backShiny: '',
                backShinyFemale: null,
                frontDefault: '',
                frontFemale: null,
                frontShiny: '',
                frontShinyFemale: null,
              ),
        stats: (json["stats"] as List<dynamic>?)
                ?.map((x) => Stat.fromJson(x))
                .toList() ??
            [],
        types: (json["types"] as List<dynamic>?)
                ?.map((x) => Type.fromJson(x))
                .toList() ??
            [],
        weight: json["weight"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "base_experience": baseExperience,
        "cries": cries.toJson(),
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
        "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
        "height": height,
        "held_items": List<dynamic>.from(heldItems.map((x) => x)),
        "id": id,
        "is_default": isDefault,
        "location_area_encounters": locationAreaEncounters,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "order": order,
        "past_abilities":
            List<dynamic>.from(pastAbilities.map((x) => x.toJson())),
        "past_types": List<dynamic>.from(pastTypes.map((x) => x)),
        "species": species.toJson(),
        "sprites": sprites.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "weight": weight,
      };
}

class Ability {
  final Species? ability;
  final bool isHidden;
  final int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: json["ability"] != null ? Species.fromJson(json["ability"]) : null,
        isHidden: json["is_hidden"] ?? false,
        slot: json["slot"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ability": ability?.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Cries {
  final String latest;
  final String legacy;

  Cries({
    required this.latest,
    required this.legacy,
  });

  factory Cries.fromJson(Map<String, dynamic> json) => Cries(
        latest: json["latest"] ?? '',
        legacy: json["legacy"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "latest": latest,
        "legacy": legacy,
      };
}

class GameIndex {
  final int gameIndex;
  final Species version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"] ?? 0,
        version: json["version"] != null ? Species.fromJson(json["version"]) : Species(name: '', url: ''),
      );

  Map<String, dynamic> toJson() => {
        "game_index": gameIndex,
        "version": version.toJson(),
      };
}

class Move {
  final Species move;
  final List<VersionGroupDetail> versionGroupDetails;

  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: json["move"] != null ? Species.fromJson(json["move"]) : Species(name: '', url: ''),
        versionGroupDetails: (json["version_group_details"] as List<dynamic>?)
                ?.map((x) => VersionGroupDetail.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "move": move.toJson(),
        "version_group_details":
            List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
      };
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final Species moveLearnMethod;
  final int? order;
  final Species versionGroup;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.order,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"] ?? 0,
        moveLearnMethod: json["move_learn_method"] != null
            ? Species.fromJson(json["move_learn_method"])
            : Species(name: '', url: ''),
        order: json["order"],
        versionGroup: json["version_group"] != null
            ? Species.fromJson(json["version_group"])
            : Species(name: '', url: ''),
      );

  Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method": moveLearnMethod.toJson(),
        "order": order,
        "version_group": versionGroup.toJson(),
      };
}

class PastAbility {
  final List<Ability> abilities;
  final Species generation;

  PastAbility({
    required this.abilities,
    required this.generation,
  });

  factory PastAbility.fromJson(Map<String, dynamic> json) => PastAbility(
        abilities: (json["abilities"] as List<dynamic>?)
                ?.map((x) => Ability.fromJson(x))
                .toList() ??
            [],
        generation: json["generation"] != null
            ? Species.fromJson(json["generation"])
            : Species(name: '', url: ''),
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "generation": generation.toJson(),
      };
}

class GenerationV {
  final Sprites blackWhite;

  GenerationV({
    required this.blackWhite,
  });

  factory GenerationV.fromJson(Map<String, dynamic> json) => GenerationV(
        blackWhite: json["black-white"] != null
            ? Sprites.fromJson(json["black-white"])
            : Sprites(
                backDefault: '',
                backFemale: null,
                backShiny: '',
                backShinyFemale: null,
                frontDefault: '',
                frontFemale: null,
                frontShiny: '',
                frontShinyFemale: null,
              ),
      );

  Map<String, dynamic> toJson() => {
        "black-white": blackWhite.toJson(),
      };
}

class GenerationIv {
  final Sprites diamondPearl;
  final Sprites heartgoldSoulsilver;
  final Sprites platinum;

  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  factory GenerationIv.fromJson(Map<String, dynamic> json) => GenerationIv(
        diamondPearl: json["diamond-pearl"] != null
            ? Sprites.fromJson(json["diamond-pearl"])
            : Sprites(
                backDefault: '',
                backFemale: null,
                backShiny: '',
                backShinyFemale: null,
                frontDefault: '',
                frontFemale: null,
                frontShiny: '',
                frontShinyFemale: null,
              ),
        heartgoldSoulsilver: json["heartgold-soulsilver"] != null
            ? Sprites.fromJson(json["heartgold-soulsilver"])
            : Sprites(
                backDefault: '',
                backFemale: null,
                backShiny: '',
                backShinyFemale: null,
                frontDefault: '',
                frontFemale: null,
                frontShiny: '',
                frontShinyFemale: null,
              ),
        platinum: json["platinum"] != null
            ? Sprites.fromJson(json["platinum"])
            : Sprites(
                backDefault: '',
                backFemale: null,
                backShiny: '',
                backShinyFemale: null,
                frontDefault: '',
                frontFemale: null,
                frontShiny: '',
                frontShinyFemale: null,
              ),
      );

  Map<String, dynamic> toJson() => {
        "diamond-pearl": diamondPearl.toJson(),
        "heartgold-soulsilver": heartgoldSoulsilver.toJson(),
        "platinum": platinum.toJson(),
      };
}

class Versions {
  final GenerationI generationI;
  final GenerationIi generationIi;
  final GenerationIii generationIii;
  final GenerationIv generationIv;
  final GenerationV generationV;
  final Map<String, Home> generationVi;
  final GenerationVii generationVii;
  final GenerationViii generationViii;

  Versions({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        generationI: json["generation-i"] != null
            ? GenerationI.fromJson(json["generation-i"])
            : GenerationI(
                redBlue: RedBlue(
                  backDefault: '',
                  backGray: '',
                  backTransparent: '',
                  frontDefault: '',
                  frontGray: '',
                  frontTransparent: '',
                ),
                yellow: RedBlue(
                  backDefault: '',
                  backGray: '',
                  backTransparent: '',
                  frontDefault: '',
                  frontGray: '',
                  frontTransparent: '',
                ),
              ),
        generationIi: json["generation-ii"] != null
            ? GenerationIi.fromJson(json["generation-ii"])
            : GenerationIi(
                crystal: Crystal(
                  backDefault: '',
                  backShiny: '',
                  backShinyTransparent: '',
                  backTransparent: '',
                  frontDefault: '',
                  frontShiny: '',
                  frontShinyTransparent: '',
                  frontTransparent: '',
                ),
                gold: Gold(
                  backDefault: '',
                  backShiny: '',
                  frontDefault: '',
                  frontShiny: '',
                  frontTransparent: null,
                ),
                silver: Gold(
                  backDefault: '',
                  backShiny: '',
                  frontDefault: '',
                  frontShiny: '',
                  frontTransparent: null,
                ),
              ),
        generationIii: json["generation-iii"] != null
            ? GenerationIii.fromJson(json["generation-iii"])
            : GenerationIii(
                emerald: OfficialArtwork(
                  frontDefault: '',
                  frontShiny: '',
                ),
                fireredLeafgreen: Gold(
                  backDefault: '',
                  backShiny: '',
                  frontDefault: '',
                  frontShiny: '',
                  frontTransparent: null,
                ),
                rubySapphire: Gold(
                  backDefault: '',
                  backShiny: '',
                  frontDefault: '',
                  frontShiny: '',
                  frontTransparent: null,
                ),
              ),
        generationIv: json["generation-iv"] != null
            ? GenerationIv.fromJson(json["generation-iv"])
            : GenerationIv(
                diamondPearl: Sprites(
                  backDefault: '',
                  backFemale: null,
                  backShiny: '',
                  backShinyFemale: null,
                  frontDefault: '',
                  frontFemale: null,
                  frontShiny: '',
                  frontShinyFemale: null,
                ),
                heartgoldSoulsilver: Sprites(
                  backDefault: '',
                  backFemale: null,
                  backShiny: '',
                  backShinyFemale: null,
                  frontDefault: '',
                  frontFemale: null,
                  frontShiny: '',
                  frontShinyFemale: null,
                ),
                platinum: Sprites(
                  backDefault: '',
                  backFemale: null,
                  backShiny: '',
                  backShinyFemale: null,
                  frontDefault: '',
                  frontFemale: null,
                  frontShiny: '',
                  frontShinyFemale: null,
                ),
              ),
        generationV: json["generation-v"] != null
            ? GenerationV.fromJson(json["generation-v"])
            : GenerationV(
                blackWhite: Sprites(
                  backDefault: '',
                  backFemale: null,
                  backShiny: '',
                  backShinyFemale: null,
                  frontDefault: '',
                  frontFemale: null,
                  frontShiny: '',
                  frontShinyFemale: null,
                ),
              ),
        generationVi: json["generation-vi"] != null
            ? Map.from(json["generation-vi"]).map(
                (k, v) => MapEntry<String, Home>(
                  k,
                  v != null ? Home.fromJson(v) : Home(frontDefault: '', frontFemale: null, frontShiny: '', frontShinyFemale: null),
                ),
              )
            : {},
        generationVii: json["generation-vii"] != null
            ? GenerationVii.fromJson(json["generation-vii"])
            : GenerationVii(
                icons: DreamWorld(
                  frontDefault: '',
                  frontFemale: null,
                ),
                ultraSunUltraMoon: Home(
                  frontDefault: '',
                  frontFemale: null,
                  frontShiny: '',
                  frontShinyFemale: null,
                ),
              ),
        generationViii: json["generation-viii"] != null
            ? GenerationViii.fromJson(json["generation-viii"])
            : GenerationViii(
                icons: DreamWorld(
                  frontDefault: '',
                  frontFemale: null,
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "generation-i": generationI.toJson(),
        "generation-ii": generationIi.toJson(),
        "generation-iii": generationIii.toJson(),
        "generation-iv": generationIv.toJson(),
        "generation-v": generationV.toJson(),
        "generation-vi": Map.from(generationVi)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "generation-vii": generationVii.toJson(),
        "generation-viii": generationViii.toJson(),
      };
}

class Other {
  final DreamWorld dreamWorld;
  final Home home;
  final OfficialArtwork officialArtwork;
  final Sprites showdown;

  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
    required this.showdown,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        dreamWorld: json["dream_world"] != null
            ? DreamWorld.fromJson(json["dream_world"])
            : DreamWorld(frontDefault: '', frontFemale: null),
        home: json["home"] != null
            ? Home.fromJson(json["home"])
            : Home(frontDefault: '', frontFemale: null, frontShiny: '', frontShinyFemale: null),
        officialArtwork: json["official-artwork"] != null
            ? OfficialArtwork.fromJson(json["official-artwork"])
            : OfficialArtwork(frontDefault: '', frontShiny: ''),
        showdown: json["showdown"] != null
            ? Sprites.fromJson(json["showdown"])
            : Sprites(
                backDefault: '',
                backFemale: null,
                backShiny: '',
                backShinyFemale: null,
                frontDefault: '',
                frontFemale: null,
                frontShiny: '',
                frontShinyFemale: null,
              ),
      );

  Map<String, dynamic> toJson() => {
        "dream_world": dreamWorld.toJson(),
        "home": home.toJson(),
        "official-artwork": officialArtwork.toJson(),
        "showdown": showdown.toJson(),
      };
}

class Sprites {
  final String backDefault;
  final dynamic backFemale;
  final String backShiny;
  final dynamic backShinyFemale;
  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;
  final Other? other;
  final Versions? versions;
  final Sprites? animated;

  Sprites({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    this.other,
    this.versions,
    this.animated,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"] ?? '',
        backFemale: json["back_female"],
        backShiny: json["back_shiny"] ?? '',
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"] ?? '',
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"] ?? '',
        frontShinyFemale: json["front_shiny_female"],
        other: json["other"] != null ? Other.fromJson(json["other"]) : null,
        versions: json["versions"] != null ? Versions.fromJson(json["versions"]) : null,
        animated: json["animated"] != null ? Sprites.fromJson(json["animated"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
        "other": other?.toJson(),
        "versions": versions?.toJson(),
        "animated": animated?.toJson(),
      };
}

class GenerationI {
  final RedBlue redBlue;
  final RedBlue yellow;

  GenerationI({
    required this.redBlue,
    required this.yellow,
  });

  factory GenerationI.fromJson(Map<String, dynamic> json) => GenerationI(
        redBlue: json["red-blue"] != null
            ? RedBlue.fromJson(json["red-blue"])
            : RedBlue(
                backDefault: '',
                backGray: '',
                backTransparent: '',
                frontDefault: '',
                frontGray: '',
                frontTransparent: '',
              ),
        yellow: json["yellow"] != null
            ? RedBlue.fromJson(json["yellow"])
            : RedBlue(
                backDefault: '',
                backGray: '',
                backTransparent: '',
                frontDefault: '',
                frontGray: '',
                frontTransparent: '',
              ),
      );

  Map<String, dynamic> toJson() => {
        "red-blue": redBlue.toJson(),
        "yellow": yellow.toJson(),
      };
}

class RedBlue {
  final String backDefault;
  final String backGray;
  final String backTransparent;
  final String frontDefault;
  final String frontGray;
  final String frontTransparent;

  RedBlue({
    required this.backDefault,
    required this.backGray,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontGray,
    required this.frontTransparent,
  });

  factory RedBlue.fromJson(Map<String, dynamic> json) => RedBlue(
        backDefault: json["back_default"] ?? '',
        backGray: json["back_gray"] ?? '',
        backTransparent: json["back_transparent"] ?? '',
        frontDefault: json["front_default"] ?? '',
        frontGray: json["front_gray"] ?? '',
        frontTransparent: json["front_transparent"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_gray": backGray,
        "back_transparent": backTransparent,
        "front_default": frontDefault,
        "front_gray": frontGray,
        "front_transparent": frontTransparent,
      };
}

class GenerationIi {
  final Crystal crystal;
  final Gold gold;
  final Gold silver;

  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  factory GenerationIi.fromJson(Map<String, dynamic> json) => GenerationIi(
        crystal: json["crystal"] != null
            ? Crystal.fromJson(json["crystal"])
            : Crystal(
                backDefault: '',
                backShiny: '',
                backShinyTransparent: '',
                backTransparent: '',
                frontDefault: '',
                frontShiny: '',
                frontShinyTransparent: '',
                frontTransparent: '',
              ),
        gold: json["gold"] != null
            ? Gold.fromJson(json["gold"])
            : Gold(
                backDefault: '',
                backShiny: '',
                frontDefault: '',
                frontShiny: '',
                frontTransparent: null,
              ),
        silver: json["silver"] != null
            ? Gold.fromJson(json["silver"])
            : Gold(
                backDefault: '',
                backShiny: '',
                frontDefault: '',
                frontShiny: '',
                frontTransparent: null,
              ),
      );

  Map<String, dynamic> toJson() => {
        "crystal": crystal.toJson(),
        "gold": gold.toJson(),
        "silver": silver.toJson(),
      };
}

class Crystal {
  final String backDefault;
  final String backShiny;
  final String backShinyTransparent;
  final String backTransparent;
  final String frontDefault;
  final String frontShiny;
  final String frontShinyTransparent;
  final String frontTransparent;

  Crystal({
    required this.backDefault,
    required this.backShiny,
    required this.backShinyTransparent,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontShinyTransparent,
    required this.frontTransparent,
  });

  factory Crystal.fromJson(Map<String, dynamic> json) => Crystal(
        backDefault: json["back_default"] ?? '',
        backShiny: json["back_shiny"] ?? '',
        backShinyTransparent: json["back_shiny_transparent"] ?? '',
        backTransparent: json["back_transparent"] ?? '',
        frontDefault: json["front_default"] ?? '',
        frontShiny: json["front_shiny"] ?? '',
        frontShinyTransparent: json["front_shiny_transparent"] ?? '',
        frontTransparent: json["front_transparent"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_shiny": backShiny,
        "back_shiny_transparent": backShinyTransparent,
        "back_transparent": backTransparent,
        "front_default": frontDefault,
        "front_shiny": frontShiny,
        "front_shiny_transparent": frontShinyTransparent,
        "front_transparent": frontTransparent,
      };
}

class Gold {
  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;
  final String? frontTransparent;

  Gold({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
    this.frontTransparent,
  });

  factory Gold.fromJson(Map<String, dynamic> json) => Gold(
        backDefault: json["back_default"] ?? '',
        backShiny: json["back_shiny"] ?? '',
        frontDefault: json["front_default"] ?? '',
        frontShiny: json["front_shiny"] ?? '',
        frontTransparent: json["front_transparent"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_shiny": backShiny,
        "front_default": frontDefault,
        "front_shiny": frontShiny,
        "front_transparent": frontTransparent,
      };
}

class GenerationIii {
  final OfficialArtwork emerald;
  final Gold fireredLeafgreen;
  final Gold rubySapphire;

  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  factory GenerationIii.fromJson(Map<String, dynamic> json) => GenerationIii(
        emerald: json["emerald"] != null
            ? OfficialArtwork.fromJson(json["emerald"])
            : OfficialArtwork(frontDefault: '', frontShiny: ''),
        fireredLeafgreen: json["firered-leafgreen"] != null
            ? Gold.fromJson(json["firered-leafgreen"])
            : Gold(backDefault: '', backShiny: '', frontDefault: '', frontShiny: '', frontTransparent: null),
        rubySapphire: json["ruby-sapphire"] != null
            ? Gold.fromJson(json["ruby-sapphire"])
            : Gold(backDefault: '', backShiny: '', frontDefault: '', frontShiny: '', frontTransparent: null),
      );

  Map<String, dynamic> toJson() => {
        "emerald": emerald.toJson(),
        "firered-leafgreen": fireredLeafgreen.toJson(),
        "ruby-sapphire": rubySapphire.toJson(),
      };
}

class OfficialArtwork {
  final String frontDefault;
  final String frontShiny;

  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      OfficialArtwork(
        frontDefault: json["front_default"] ?? '',
        frontShiny: json["front_shiny"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_shiny": frontShiny,
      };
}

class Home {
  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;

  Home({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        frontDefault: json["front_default"] ?? '',
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"] ?? '',
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class GenerationVii {
  final DreamWorld icons;
  final Home ultraSunUltraMoon;

  GenerationVii({
    required this.icons,
    required this.ultraSunUltraMoon,
  });

  factory GenerationVii.fromJson(Map<String, dynamic> json) => GenerationVii(
        icons: json["icons"] != null
            ? DreamWorld.fromJson(json["icons"])
            : DreamWorld(frontDefault: '', frontFemale: null),
        ultraSunUltraMoon: json["ultra-sun-ultra-moon"] != null
            ? Home.fromJson(json["ultra-sun-ultra-moon"])
            : Home(frontDefault: '', frontFemale: null, frontShiny: '', frontShinyFemale: null),
      );

  Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
        "ultra-sun-ultra-moon": ultraSunUltraMoon.toJson(),
      };
}

class DreamWorld {
  final String frontDefault;
  final dynamic frontFemale;

  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });
  factory DreamWorld.fromJson(Map<String, dynamic> json) => DreamWorld(
        frontDefault: json["front_default"] ?? '',
        frontFemale: json["front_female"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
      };
}

class GenerationViii {
  final DreamWorld icons;

  GenerationViii({
    required this.icons,
  });

  factory GenerationViii.fromJson(Map<String, dynamic> json) => GenerationViii(
        icons: json["icons"] != null
            ? DreamWorld.fromJson(json["icons"])
            : DreamWorld(frontDefault: '', frontFemale: null),
      );

  Map<String, dynamic> toJson() => {
        "icons": icons.toJson(),
      };
}

class Stat {
  final int baseStat;
  final int effort;
  final Species stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"] ?? 0,
        effort: json["effort"] ?? 0,
        stat: json["stat"] != null ? Species.fromJson(json["stat"]) : Species(name: '', url: ''),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

class Type {
  final int slot;
  final Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"] ?? 0,
        type: json["type"] != null ? Species.fromJson(json["type"]) : Species(name: '', url: ''),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}

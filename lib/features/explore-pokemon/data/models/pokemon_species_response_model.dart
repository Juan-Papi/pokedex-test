import 'package:pokedex/features/explore-pokemon/data/mappers/pokemon_species_mapper.dart';
import 'package:pokedex/features/explore-pokemon/domain/entities/pokemon_species_entity.dart';

class PokemonSpeciesAboutResponse {
  final int baseHappiness;
  final int captureRate;
  final Color color;
  final List<Color> eggGroups;
  final EvolutionChain evolutionChain;
  final dynamic evolvesFromSpecies;
  final List<FlavorTextEntry> flavorTextEntries;
  final List<dynamic> formDescriptions;
  final bool formsSwitchable;
  final int genderRate;
  final List<Genus> genera;
  final Color generation;
  final Color growthRate;
  final Color habitat;
  final bool hasGenderDifferences;
  final int hatchCounter;
  final int id;
  final bool isBaby;
  final bool isLegendary;
  final bool isMythical;
  final String name;
  final List<Name> names;
  final int order;
  final List<PalParkEncounter> palParkEncounters;
  final List<PokedexNumber> pokedexNumbers;
  final Color shape;
  final List<Variety> varieties;

  PokemonSpeciesAboutResponse({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.eggGroups,
    required this.evolutionChain,
    required this.evolvesFromSpecies,
    required this.flavorTextEntries,
    required this.formDescriptions,
    required this.formsSwitchable,
    required this.genderRate,
    required this.genera,
    required this.generation,
    required this.growthRate,
    required this.habitat,
    required this.hasGenderDifferences,
    required this.hatchCounter,
    required this.id,
    required this.isBaby,
    required this.isLegendary,
    required this.isMythical,
    required this.name,
    required this.names,
    required this.order,
    required this.palParkEncounters,
    required this.pokedexNumbers,
    required this.shape,
    required this.varieties,
  });

  factory PokemonSpeciesAboutResponse.fromJson(Map<String, dynamic> json) =>
      PokemonSpeciesAboutResponse(
        baseHappiness: json["base_happiness"] ?? 0,
        captureRate: json["capture_rate"] ?? 0,
        color: json["color"] != null
            ? Color.fromJson(json["color"])
            : Color(name: "unknown", url: ""),
        eggGroups: json["egg_groups"] != null
            ? List<Color>.from(json["egg_groups"].map((x) => Color.fromJson(x)))
            : [],
        evolutionChain: json["evolution_chain"] != null
            ? EvolutionChain.fromJson(json["evolution_chain"])
            : EvolutionChain(url: ""),
        evolvesFromSpecies: json["evolves_from_species"],
        flavorTextEntries: json["flavor_text_entries"] != null
            ? List<FlavorTextEntry>.from(json["flavor_text_entries"]
                .map((x) => FlavorTextEntry.fromJson(x)))
            : [],
        formDescriptions: json["form_descriptions"] != null
            ? List<dynamic>.from(json["form_descriptions"])
            : [],
        formsSwitchable: json["forms_switchable"] ?? false,
        genderRate: json["gender_rate"] ?? -1,
        genera: json["genera"] != null
            ? List<Genus>.from(json["genera"].map((x) => Genus.fromJson(x)))
            : [],
        generation: json["generation"] != null
            ? Color.fromJson(json["generation"])
            : Color(name: "unknown", url: ""),
        growthRate: json["growth_rate"] != null
            ? Color.fromJson(json["growth_rate"])
            : Color(name: "unknown", url: ""),
        habitat: json["habitat"] != null
            ? Color.fromJson(json["habitat"])
            : Color(name: "unknown", url: ""),
        hasGenderDifferences: json["has_gender_differences"] ?? false,
        hatchCounter: json["hatch_counter"] ?? 0,
        id: json["id"] ?? 0,
        isBaby: json["is_baby"] ?? false,
        isLegendary: json["is_legendary"] ?? false,
        isMythical: json["is_mythical"] ?? false,
        name: json["name"] ?? "unknown",
        names: json["names"] != null
            ? List<Name>.from(json["names"].map((x) => Name.fromJson(x)))
            : [],
        order: json["order"] ?? 0,
        palParkEncounters: json["pal_park_encounters"] != null
            ? List<PalParkEncounter>.from(json["pal_park_encounters"]
                .map((x) => PalParkEncounter.fromJson(x)))
            : [],
        pokedexNumbers: json["pokedex_numbers"] != null
            ? List<PokedexNumber>.from(
                json["pokedex_numbers"].map((x) => PokedexNumber.fromJson(x)))
            : [],
        shape: json["shape"] != null
            ? Color.fromJson(json["shape"])
            : Color(name: "unknown", url: ""),
        varieties: json["varieties"] != null
            ? List<Variety>.from(
                json["varieties"].map((x) => Variety.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "base_happiness": baseHappiness,
        "capture_rate": captureRate,
        "color": color.toJson(),
        "egg_groups": List<dynamic>.from(eggGroups.map((x) => x.toJson())),
        "evolution_chain": evolutionChain.toJson(),
        "evolves_from_species": evolvesFromSpecies,
        "flavor_text_entries":
            List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
        "form_descriptions": List<dynamic>.from(formDescriptions.map((x) => x)),
        "forms_switchable": formsSwitchable,
        "gender_rate": genderRate,
        "genera": List<dynamic>.from(genera.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "growth_rate": growthRate.toJson(),
        "habitat": habitat.toJson(),
        "has_gender_differences": hasGenderDifferences,
        "hatch_counter": hatchCounter,
        "id": id,
        "is_baby": isBaby,
        "is_legendary": isLegendary,
        "is_mythical": isMythical,
        "name": name,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
        "order": order,
        "pal_park_encounters":
            List<dynamic>.from(palParkEncounters.map((x) => x.toJson())),
        "pokedex_numbers":
            List<dynamic>.from(pokedexNumbers.map((x) => x.toJson())),
        "shape": shape.toJson(),
        "varieties": List<dynamic>.from(varieties.map((x) => x.toJson())),
      };
}

class Color {
  final String name;
  final String url;

  Color({
    required this.name,
    required this.url,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        name: json["name"] ?? "unknown",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class EvolutionChain {
  final String url;

  EvolutionChain({
    required this.url,
  });

  factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class FlavorTextEntry {
  final String flavorText;
  final Color language;
  final Color version;

  FlavorTextEntry({
    required this.flavorText,
    required this.language,
    required this.version,
  });

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) =>
      FlavorTextEntry(
        flavorText: json["flavor_text"] ?? "",
        language:
            Color.fromJson(json["language"]) ?? Color(name: "unknown", url: ""),
        version:
            Color.fromJson(json["version"]) ?? Color(name: "unknown", url: ""),
      );

  Map<String, dynamic> toJson() => {
        "flavor_text": flavorText,
        "language": language.toJson(),
        "version": version.toJson(),
      };
}

class Genus {
  final String genus;
  final Color language;

  Genus({
    required this.genus,
    required this.language,
  });

  factory Genus.fromJson(Map<String, dynamic> json) => Genus(
        genus: json["genus"] ?? "",
        language: json["language"] != null
            ? Color.fromJson(json["language"])
            : Color(name: "unknown", url: ""),
      );

  Map<String, dynamic> toJson() => {
        "genus": genus,
        "language": language.toJson(),
      };
}

class Name {
  final Color language;
  final String name;

  Name({
    required this.language,
    required this.name,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        language: json["language"] != null
            ? Color.fromJson(json["language"])
            : Color(name: "unknown", url: ""),
        name: json["name"] ?? "unknown",
      );

  Map<String, dynamic> toJson() => {
        "language": language.toJson(),
        "name": name,
      };
}

class PalParkEncounter {
  final Color area;
  final int baseScore;
  final int rate;

  PalParkEncounter({
    required this.area,
    required this.baseScore,
    required this.rate,
  });

  factory PalParkEncounter.fromJson(Map<String, dynamic> json) =>
      PalParkEncounter(
        area: json["area"] != null
            ? Color.fromJson(json["area"])
            : Color(name: "unknown", url: ""),
        baseScore: json["base_score"] ?? 0,
        rate: json["rate"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "area": area.toJson(),
        "base_score": baseScore,
        "rate": rate,
      };
}

class PokedexNumber {
  final int entryNumber;
  final Color pokedex;

  PokedexNumber({
    required this.entryNumber,
    required this.pokedex,
  });

  factory PokedexNumber.fromJson(Map<String, dynamic> json) => PokedexNumber(
        entryNumber: json["entry_number"] ?? 0,
        pokedex: json["pokedex"] != null
            ? Color.fromJson(json["pokedex"])
            : Color(name: "unknown", url: ""),
      );

  Map<String, dynamic> toJson() => {
        "entry_number": entryNumber,
        "pokedex": pokedex.toJson(),
      };
}

class Variety {
  final bool isDefault;
  PokemonSpecies pokemon;

  Variety({
    required this.isDefault,
    required this.pokemon,
  });

  factory Variety.fromJson(Map<String, dynamic> json) => Variety(
        isDefault: json["is_default"] ?? false,
        pokemon: json["pokemon"] != null
            ? PokemonSpeciesMapper.fromJson(json["pokemon"])
            : throw Exception("Pokemon data is missing"),
      );

  Map<String, dynamic> toJson() => {
        "is_default": isDefault,
        "pokemon": PokemonSpeciesMapper.toJson(pokemon),
      };
}

import pandas as pd
import sqlalchemy as alch

def clean(path_csv, name):
    '''
    Reads csv, renames columns, drops long textual columns, converts to float the power_scores, and recategorizes superpowers.
    '''
    
    df = pd.read_csv(path_csv)
    df_clean = df
    df_clean.drop_duplicates(subset=["real_name"], inplace=True)
    df_clean.dropna(subset=["alignment"], inplace=True)
    df_clean.rename(columns= {"has_self-sustenance":"has_self_sustenance", "has_weapon-based_powers": "has_weapon_based_powers"}, inplace = True)
    df_clean.drop(columns=["history_text", "powers_text", "superpowers", "alter_egos", "aliases", "first_appearance", "occupation", "teams", "relatives", "height", "weight", "eye_color", "hair_color", "skin_color", "img"], inplace = True)
    df_clean["n_superpowers"] = df_clean.has_electrokinesis + df_clean.has_energy_constructs + df_clean.has_mind_control_resistance + df_clean.has_matter_manipulation + df_clean.has_telepathy_resistance + df_clean.has_mind_control + df_clean.has_enhanced_hearing + df_clean.has_dimensional_travel + df_clean.has_element_control + df_clean.has_size_changing + df_clean.has_fire_resistance + df_clean.has_fire_control + df_clean.has_dexterity + df_clean.has_reality_warping + df_clean.has_illusions + df_clean.has_energy_beams + df_clean.has_peak_human_condition + df_clean.has_shapeshifting + df_clean.has_heat_resistance + df_clean.has_jump + df_clean.has_self_sustenance + df_clean.has_energy_absorption + df_clean.has_cold_resistance + df_clean.has_magic + df_clean.has_telekinesis + df_clean.has_toxin_and_disease_resistance + df_clean.has_telepathy + df_clean.has_regeneration + df_clean.has_immortality + df_clean.has_teleportation + df_clean.has_force_fields + df_clean.has_energy_manipulation + df_clean.has_endurance + df_clean.has_longevity + df_clean.has_weapon_based_powers + df_clean.has_energy_blasts + df_clean.has_enhanced_senses + df_clean.has_invulnerability + df_clean.has_stealth + df_clean.has_marksmanship + df_clean.has_flight + df_clean.has_accelerated_healing + df_clean.has_weapons_master + df_clean.has_intelligence + df_clean.has_reflexes + df_clean.has_super_speed + df_clean.has_durability + df_clean.has_stamina + df_clean.has_agility + df_clean.has_super_strength
    df_clean.loc[df_clean["overall_score"][df["overall_score"] == "∞"].index, "overall_score"] = 100000000
    df_clean.loc[df_clean["overall_score"][df["overall_score"] == "-"].index, "overall_score"] = float('nan')
    df_clean = df_clean.astype({"overall_score":float})
    df_clean["energy_powers"] = df_clean["has_electrokinesis"] + df_clean["has_energy_constructs"] + df_clean["has_energy_beams"] + df_clean["has_energy_blasts"] + df_clean["has_energy_manipulation"] + df_clean["has_energy_absorption"] + df_clean["has_force_fields"]
    df_clean["matter_powers"] = df_clean["has_matter_manipulation"] + df_clean["has_element_control"] + df_clean["has_telekinesis"] + df_clean["has_fire_control"]
    df_clean["self_powers"] = df_clean["has_size_changing"] +  df_clean["has_shapeshifting"] +  df_clean["has_teleportation"]
    df_clean["reality_powers"] = df_clean["has_reality_warping"] + df_clean["has_illusions"] + df_clean["has_magic"] + df_clean["has_dimensional_travel"] 
    df_clean["mind_powers"] = df_clean["has_mind_control"] + df_clean["has_telepathy"] + df_clean["has_intelligence"]
    df_clean["resistance_powers"] = df_clean["has_mind_control_resistance"] + df_clean["has_telepathy_resistance"] + df_clean["has_heat_resistance"] + df_clean["has_fire_resistance"] + df_clean["has_cold_resistance"] + df_clean["has_toxin_and_disease_resistance"]
    df_clean["invulnerability"] = df_clean["has_peak_human_condition"] + df_clean["has_immortality"] + df_clean["has_longevity"] + df_clean["has_invulnerability"] + df_clean["has_regeneration"] + df_clean["has_accelerated_healing"] + df_clean["has_self_sustenance"] 
    df_clean["supersenses"] = df_clean["has_enhanced_senses"] + df_clean["has_enhanced_hearing"]
    df_clean["stamina"] = df_clean["has_endurance"] + df_clean["has_durability"] +  df_clean["has_stamina"]
    df_clean["jump_flight"] = df_clean["has_jump"] +  df_clean["has_flight"]
    df_clean["stealth"] = df_clean["has_stealth"]
    df_clean["speed"] = df_clean["has_super_speed"]
    df_clean["strength"] = df_clean["has_super_strength"]
    df_clean["weapons"] = df_clean["has_weapon_based_powers"] + df_clean["has_weapons_master"]
    df_clean.to_csv(f"data/{name}.csv")
    


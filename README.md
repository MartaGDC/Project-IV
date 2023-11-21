# Project-IV.
Links:
- [GitHub](https://github.com/MartaGDC/Project-IV/)
- [Tableau](https://public.tableau.com/views/heros_17004379997200/Story1?:language=es-ES&publish=yes&:display_count=n&:origin=viz_share_link)

## Datasets
From kaggle I obtained this [database](https://github.com/MartaGDC/Project-IV/blob/main/data/heros.csv#:~:text=queries_results-,heros.csv,-original_superheros.csv).

It contains information about superheros and villains from different sources, their superpowers and strengths.

## Questions
- Heros and villains by creators
    - Number of heros and villains by creators
    - Show only if there are more villains than heros
    - Show information about these villains
- Power by heros and villains
    - Power of the most powerful hero, villain and neutral
    - Who are they?
- Superpowers
    - Number of superpowers in heros, villains and neutrals
    - Type of prefered powers by heros, villains and neutrals
    - Groups of types of prefered powers
- Sex and races
    - Alignment
    - Power
    - Superpowers

## Process
1. ETL: this is the resulting [database](data\heros.csv).
2. EDA:
    - Using python's conection with MySQL to answer the proposed questions.
    - Using Tableau to visualize the relevant conclusions from the previous exploration.

## Conclusion:
1. Marvel Comics, DC Comics, Unknown, Dark Horse COmics, Shueisha, NBC - Heroes, Lego, Ubisoft, George Lucas, Image Comics are the top 10 creators of heros and villains.

    But some creators prefer villains.
2. The creators who prefer villains to heros are Image Comics, Hasbro, Konami, Mathel and the author Stephen King with his creature Pennywise.
3. The most powerful beings have a score of 100000000 (or infinite), but the average power is higher for heros than for villains. 

    Both shadowed by the power score of neutral creatures.
4. However, the number of heros with the highest power score is bigger than the number of neutral creatures wiith the highest power score.

    All of the most powerful characters are not-human.
    
    The most powerful females always prefer to define themselves as neutral.
5. The most common superpower group for heros is Capabilities.
This includes dexterity, agility, reflexes and marksmanship.

    For villains and neutrals, the most common superpower group is Invulnerability.
    
    This includes peak human condition, inmortality, longevity, invulnerability, regeneration, accelerated healing and self-sustenance.
6. The are differences according to sex and race:
    - Not human males' most common superpowers are related to invulnerability independently of alignment.
    - Neutral and good not human females' most common superpowers are related to capabilities, while villains' ones are related to invulnerability
    - Human males and females' most common suuperpowers are related to capabilities, independently of alignment.

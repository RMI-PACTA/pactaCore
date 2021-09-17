# outputs datasets with the expected structure

    Code
      dimensions
    Output
      $Bonds_results_company
      [1] 17664    36
      
      $Bonds_results_map
      [1] 7626   15
      
      $Bonds_results_portfolio
      [1] 1596   29
      
      $Equity_results_company
      [1] 947384     36
      
      $Equity_results_map
      [1] 43189    15
      
      $Equity_results_portfolio
      [1] 3397   29
      

---

    Code
      classes
    Output
      $Bonds_results_company
                  investor_name            portfolio_name                  scenario 
                    "character"               "character"               "character" 
                     allocation                        id              company_name 
                    "character"               "character"               "character" 
               financial_sector               port_weight         allocation_weight 
                    "character"                 "numeric"                 "numeric" 
          plan_br_dist_alloc_wt     scen_br_dist_alloc_wt             equity_market 
                      "numeric"                 "numeric"               "character" 
             scenario_geography                      year                ald_sector 
                    "character"                 "numeric"               "character" 
                     technology            plan_tech_prod   plan_alloc_wt_tech_prod 
                    "character"                 "numeric"                 "numeric" 
                   plan_carsten      plan_emission_factor            scen_tech_prod 
                      "numeric"                 "numeric"                 "numeric" 
        scen_alloc_wt_tech_prod              scen_carsten      scen_emission_factor 
                      "numeric"                 "numeric"                 "numeric" 
                  plan_sec_prod    plan_alloc_wt_sec_prod          plan_sec_carsten 
                      "numeric"                 "numeric"                 "numeric" 
      plan_sec_emissions_factor             scen_sec_prod    scen_alloc_wt_sec_prod 
                      "numeric"                 "numeric"                 "numeric" 
               scen_sec_carsten scen_sec_emissions_factor           plan_tech_share 
                      "numeric"                 "numeric"                 "numeric" 
                scen_tech_share      trajectory_deviation      trajectory_alignment 
                      "numeric"                 "numeric"                 "numeric" 
      
      $Bonds_results_map
                investor_name          portfolio_name            ald_location 
                  "character"             "character"             "character" 
                         year              ald_sector              technology 
                    "numeric"             "character"             "character" 
             financial_sector              allocation       allocation_weight 
                  "character"             "character"               "numeric" 
          ald_production_unit plan_alloc_wt_tech_prod  plan_alloc_wt_sec_prod 
                  "character"               "numeric"               "numeric" 
                equity_market                scenario      scenario_geography 
                  "character"               "logical"               "logical" 
      
      $Bonds_results_portfolio
                  investor_name            portfolio_name                  scenario 
                    "character"               "character"               "character" 
                     allocation             equity_market        scenario_geography 
                    "character"               "character"               "character" 
                           year                ald_sector                technology 
                      "numeric"               "character"               "character" 
                 plan_tech_prod   plan_alloc_wt_tech_prod              plan_carsten 
                      "numeric"                 "numeric"                 "numeric" 
           plan_emission_factor            scen_tech_prod   scen_alloc_wt_tech_prod 
                      "numeric"                 "numeric"                 "numeric" 
                   scen_carsten      scen_emission_factor             plan_sec_prod 
                      "numeric"                 "numeric"                 "numeric" 
         plan_alloc_wt_sec_prod          plan_sec_carsten plan_sec_emissions_factor 
                      "numeric"                 "numeric"                 "numeric" 
                  scen_sec_prod    scen_alloc_wt_sec_prod          scen_sec_carsten 
                      "numeric"                 "numeric"                 "numeric" 
      scen_sec_emissions_factor           plan_tech_share           scen_tech_share 
                      "numeric"                 "numeric"                 "numeric" 
           trajectory_deviation      trajectory_alignment 
                      "numeric"                 "numeric" 
      
      $Equity_results_company
                  investor_name            portfolio_name                  scenario 
                    "character"               "character"               "character" 
                     allocation                        id              company_name 
                    "character"               "character"               "character" 
               financial_sector               port_weight         allocation_weight 
                    "character"                 "numeric"                 "numeric" 
          plan_br_dist_alloc_wt     scen_br_dist_alloc_wt             equity_market 
                      "numeric"                 "numeric"               "character" 
             scenario_geography                      year                ald_sector 
                    "character"                 "numeric"               "character" 
                     technology            plan_tech_prod   plan_alloc_wt_tech_prod 
                    "character"                 "numeric"                 "numeric" 
                   plan_carsten      plan_emission_factor            scen_tech_prod 
                      "numeric"                 "numeric"                 "numeric" 
        scen_alloc_wt_tech_prod              scen_carsten      scen_emission_factor 
                      "numeric"                 "numeric"                 "numeric" 
                  plan_sec_prod    plan_alloc_wt_sec_prod          plan_sec_carsten 
                      "numeric"                 "numeric"                 "numeric" 
      plan_sec_emissions_factor             scen_sec_prod    scen_alloc_wt_sec_prod 
                      "numeric"                 "numeric"                 "numeric" 
               scen_sec_carsten scen_sec_emissions_factor           plan_tech_share 
                      "numeric"                 "numeric"                 "numeric" 
                scen_tech_share      trajectory_deviation      trajectory_alignment 
                      "numeric"                 "numeric"                 "numeric" 
      
      $Equity_results_map
                investor_name          portfolio_name            ald_location 
                  "character"             "character"             "character" 
                         year              ald_sector              technology 
                    "numeric"             "character"             "character" 
             financial_sector              allocation       allocation_weight 
                  "character"             "character"               "numeric" 
          ald_production_unit plan_alloc_wt_tech_prod  plan_alloc_wt_sec_prod 
                  "character"               "numeric"               "numeric" 
                equity_market                scenario      scenario_geography 
                  "character"               "logical"               "logical" 
      
      $Equity_results_portfolio
                  investor_name            portfolio_name                  scenario 
                    "character"               "character"               "character" 
                     allocation             equity_market        scenario_geography 
                    "character"               "character"               "character" 
                           year                ald_sector                technology 
                      "numeric"               "character"               "character" 
                 plan_tech_prod   plan_alloc_wt_tech_prod              plan_carsten 
                      "numeric"                 "numeric"                 "numeric" 
           plan_emission_factor            scen_tech_prod   scen_alloc_wt_tech_prod 
                      "numeric"                 "numeric"                 "numeric" 
                   scen_carsten      scen_emission_factor             plan_sec_prod 
                      "numeric"                 "numeric"                 "numeric" 
         plan_alloc_wt_sec_prod          plan_sec_carsten plan_sec_emissions_factor 
                      "numeric"                 "numeric"                 "numeric" 
                  scen_sec_prod    scen_alloc_wt_sec_prod          scen_sec_carsten 
                      "numeric"                 "numeric"                 "numeric" 
      scen_sec_emissions_factor           plan_tech_share           scen_tech_share 
                      "numeric"                 "numeric"                 "numeric" 
           trajectory_deviation      trajectory_alignment 
                      "numeric"                 "numeric" 
      

# without portfolio errors gracefully

    The input/ directory must have at least one pair of files:
    * A porfolio file named <pair-name>_Input.csv.
    * A parameter file named <pair-name>_Input_PortfolioParameters.yml.
    Is your setup as per https://github.com/2DegreesInvesting/pactaCore?

# without a parameter file errors gracefully

    The input/ directory must have at least one pair of files:
    * A porfolio file named <pair-name>_Input.csv.
    * A parameter file named <pair-name>_Input_PortfolioParameters.yml.
    Is your setup as per https://github.com/2DegreesInvesting/pactaCore?


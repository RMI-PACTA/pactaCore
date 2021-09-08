# creates the expected results

    Code
      datasets
    Output
      $Bonds_results_company
      # A tibble: 17,664 x 36
         investor_name portfolio_name      scenario     allocation       id    company_name
         <chr>         <chr>               <chr>        <chr>            <chr> <chr>       
       1 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       2 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       3 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       4 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       5 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       6 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       7 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       8 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
       9 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
      10 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight MTNA  Arcelormitt~
      # ... with 17,654 more rows, and 30 more variables: financial_sector <chr>,
      #   port_weight <dbl>, allocation_weight <dbl>, plan_br_dist_alloc_wt <dbl>,
      #   scen_br_dist_alloc_wt <dbl>, equity_market <chr>, scenario_geography <chr>,
      #   year <dbl>, ald_sector <chr>, technology <chr>, plan_tech_prod <dbl>,
      #   plan_alloc_wt_tech_prod <dbl>, plan_carsten <dbl>,
      #   plan_emission_factor <dbl>, scen_tech_prod <dbl>,
      #   scen_alloc_wt_tech_prod <dbl>, scen_carsten <dbl>, ...
      
      $Bonds_results_map
      # A tibble: 7,626 x 15
         investor_name portfolio_name      ald_location  year ald_sector technology   
         <chr>         <chr>               <chr>        <dbl> <chr>      <chr>        
       1 Test          TestPortfolio_Input AE            2020 Cement     Grinding     
       2 Test          TestPortfolio_Input AE            2020 Cement     Integrated f~
       3 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       4 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       5 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       6 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       7 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       8 Test          TestPortfolio_Input AE            2020 Oil&Gas    Oil          
       9 Test          TestPortfolio_Input AE            2020 Oil&Gas    Oil          
      10 Test          TestPortfolio_Input AE            2020 Oil&Gas    Oil          
      # ... with 7,616 more rows, and 9 more variables: financial_sector <chr>,
      #   allocation <chr>, allocation_weight <dbl>, ald_production_unit <chr>,
      #   plan_alloc_wt_tech_prod <dbl>, plan_alloc_wt_sec_prod <dbl>,
      #   equity_market <chr>, scenario <lgl>, scenario_geography <lgl>
      
      $Bonds_results_portfolio
      # A tibble: 1,596 x 29
         investor_name portfolio_name      scenario     allocation       equity_market
         <chr>         <chr>               <chr>        <chr>            <chr>        
       1 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       2 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       3 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       4 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       5 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       6 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       7 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       8 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       9 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
      10 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
      # ... with 1,586 more rows, and 24 more variables: scenario_geography <chr>,
      #   year <dbl>, ald_sector <chr>, technology <chr>, plan_tech_prod <dbl>,
      #   plan_alloc_wt_tech_prod <dbl>, plan_carsten <dbl>,
      #   plan_emission_factor <dbl>, scen_tech_prod <dbl>,
      #   scen_alloc_wt_tech_prod <dbl>, scen_carsten <dbl>,
      #   scen_emission_factor <dbl>, plan_sec_prod <dbl>,
      #   plan_alloc_wt_sec_prod <dbl>, plan_sec_carsten <dbl>, ...
      
      $Equity_results_company
      # A tibble: 947,384 x 36
         investor_name portfolio_name      scenario      allocation       id     company_name
         <chr>         <chr>               <chr>         <chr>            <chr>  <chr>       
       1 Test          TestPortfolio_Input ETP2017_B2DS  portfolio_weight 328069 A2a Spa     
       2 Test          TestPortfolio_Input WEO2019_CPS   portfolio_weight 328069 A2a Spa     
       3 Test          TestPortfolio_Input WEO2019_NPS   portfolio_weight 328069 A2a Spa     
       4 Test          TestPortfolio_Input WEO2019_SDS   portfolio_weight 328069 A2a Spa     
       5 Test          TestPortfolio_Input GECO2019_1.5c portfolio_weight 328069 A2a Spa     
       6 Test          TestPortfolio_Input GECO2019_2c_m portfolio_weight 328069 A2a Spa     
       7 Test          TestPortfolio_Input GECO2019_ref  portfolio_weight 328069 A2a Spa     
       8 Test          TestPortfolio_Input WEO2020_NPS   portfolio_weight 328069 A2a Spa     
       9 Test          TestPortfolio_Input WEO2020_SDS   portfolio_weight 328069 A2a Spa     
      10 Test          TestPortfolio_Input ETP2017_B2DS  portfolio_weight 328069 A2a Spa     
      # ... with 947,374 more rows, and 30 more variables: financial_sector <chr>,
      #   port_weight <dbl>, allocation_weight <dbl>, plan_br_dist_alloc_wt <dbl>,
      #   scen_br_dist_alloc_wt <dbl>, equity_market <chr>, scenario_geography <chr>,
      #   year <dbl>, ald_sector <chr>, technology <chr>, plan_tech_prod <dbl>,
      #   plan_alloc_wt_tech_prod <dbl>, plan_carsten <dbl>,
      #   plan_emission_factor <dbl>, scen_tech_prod <dbl>,
      #   scen_alloc_wt_tech_prod <dbl>, scen_carsten <dbl>, ...
      
      $Equity_results_map
      # A tibble: 44,282 x 15
         investor_name portfolio_name      ald_location  year ald_sector technology   
         <chr>         <chr>               <chr>        <dbl> <chr>      <chr>        
       1 Test          TestPortfolio_Input AE            2020 Cement     Grinding     
       2 Test          TestPortfolio_Input AE            2020 Cement     Grinding     
       3 Test          TestPortfolio_Input AE            2020 Cement     Integrated f~
       4 Test          TestPortfolio_Input AE            2020 Cement     Integrated f~
       5 Test          TestPortfolio_Input AE            2020 Cement     Integrated f~
       6 Test          TestPortfolio_Input AE            2020 Cement     Integrated f~
       7 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       8 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
       9 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
      10 Test          TestPortfolio_Input AE            2020 Oil&Gas    Gas          
      # ... with 44,272 more rows, and 9 more variables: financial_sector <chr>,
      #   allocation <chr>, allocation_weight <dbl>, ald_production_unit <chr>,
      #   plan_alloc_wt_tech_prod <dbl>, plan_alloc_wt_sec_prod <dbl>,
      #   equity_market <chr>, scenario <lgl>, scenario_geography <lgl>
      
      $Equity_results_portfolio
      # A tibble: 3,397 x 29
         investor_name portfolio_name      scenario     allocation       equity_market
         <chr>         <chr>               <chr>        <chr>            <chr>        
       1 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       2 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       3 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       4 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       5 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       6 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       7 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       8 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
       9 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
      10 Test          TestPortfolio_Input ETP2017_B2DS portfolio_weight GlobalMarket 
      # ... with 3,387 more rows, and 24 more variables: scenario_geography <chr>,
      #   year <dbl>, ald_sector <chr>, technology <chr>, plan_tech_prod <dbl>,
      #   plan_alloc_wt_tech_prod <dbl>, plan_carsten <dbl>,
      #   plan_emission_factor <dbl>, scen_tech_prod <dbl>,
      #   scen_alloc_wt_tech_prod <dbl>, scen_carsten <dbl>,
      #   scen_emission_factor <dbl>, plan_sec_prod <dbl>,
      #   plan_alloc_wt_sec_prod <dbl>, plan_sec_carsten <dbl>, ...
      
      $Stress_test_results_IPR
      # A tibble: 29 x 9
         investor_name portfolio_name  sector subsector  exposure description scenario
         <chr>         <chr>           <chr>  <chr>         <dbl> <chr>       <chr>   
       1 Test          TestPortfolio_~ Busin~ Business ~  369456. <NA>        IPR     
       2 Test          TestPortfolio_~ Consu~ Consumer ~   23074. <NA>        IPR     
       3 Test          TestPortfolio_~ Consu~ Consumer ~   79764. <NA>        IPR     
       4 Test          TestPortfolio_~ Consu~ Consumer ~  505515. <NA>        IPR     
       5 Test          TestPortfolio_~ Consu~ Miscellan~   13368. <NA>        IPR     
       6 Test          TestPortfolio_~ Consu~ Food and ~   48782. <NA>        IPR     
       7 Test          TestPortfolio_~ Consu~ Food and ~  174370. <NA>        IPR     
       8 Test          TestPortfolio_~ Consu~ Hospitali~   74869. <NA>        IPR     
       9 Test          TestPortfolio_~ Consu~ Media and~    2886. <NA>        IPR     
      10 Test          TestPortfolio_~ Energy Downstrea~  283876. <NA>        IPR     
      # ... with 19 more rows, and 2 more variables: shock <dbl>, loss <dbl>
      
      $bonds_results_stress_test
      # A tibble: 11 x 18
         investor_name portfolio_name      ald_sector technology    scenario_geography
         <chr>         <chr>               <chr>      <chr>         <chr>             
       1 Test          TestPortfolio_Input Automotive Electric      Global            
       2 Test          TestPortfolio_Input Automotive Hybrid        Global            
       3 Test          TestPortfolio_Input Automotive ICE           Global            
       4 Test          TestPortfolio_Input Oil&Gas    Gas           Global            
       5 Test          TestPortfolio_Input Oil&Gas    Oil           Global            
       6 Test          TestPortfolio_Input Power      CoalCap       Global            
       7 Test          TestPortfolio_Input Power      GasCap        Global            
       8 Test          TestPortfolio_Input Power      HydroCap      Global            
       9 Test          TestPortfolio_Input Power      NuclearCap    Global            
      10 Test          TestPortfolio_Input Power      OilCap        Global            
      11 Test          TestPortfolio_Input Power      RenewablesCap Global            
      # ... with 13 more variables: VaR_technology <dbl>,
      #   asset_portfolio_value <dbl>, VaR_sector <dbl>, scenario_name <chr>,
      #   technology_exposure <dbl>, sector_exposure <dbl>, sector_loss <dbl>,
      #   climate_relevant_var <dbl>, portfolio_aum <dbl>, portfolio_loss_perc <dbl>,
      #   year_of_shock <dbl>, duration_of_shock <dbl>, production_shock_perc <lgl>
      
      $equity_results_stress_test
      # A tibble: 12 x 18
         investor_name portfolio_name      ald_sector technology    scenario_geography
         <chr>         <chr>               <chr>      <chr>         <chr>             
       1 Test          TestPortfolio_Input Automotive Electric      Global            
       2 Test          TestPortfolio_Input Automotive Hybrid        Global            
       3 Test          TestPortfolio_Input Automotive ICE           Global            
       4 Test          TestPortfolio_Input Coal       Coal          Global            
       5 Test          TestPortfolio_Input Oil&Gas    Gas           Global            
       6 Test          TestPortfolio_Input Oil&Gas    Oil           Global            
       7 Test          TestPortfolio_Input Power      CoalCap       Global            
       8 Test          TestPortfolio_Input Power      GasCap        Global            
       9 Test          TestPortfolio_Input Power      HydroCap      Global            
      10 Test          TestPortfolio_Input Power      NuclearCap    Global            
      11 Test          TestPortfolio_Input Power      OilCap        Global            
      12 Test          TestPortfolio_Input Power      RenewablesCap Global            
      # ... with 13 more variables: VaR_technology <dbl>,
      #   asset_portfolio_value <dbl>, VaR_sector <dbl>, scenario_name <chr>,
      #   technology_exposure <dbl>, sector_exposure <dbl>, sector_loss <dbl>,
      #   climate_relevant_var <dbl>, portfolio_aum <dbl>, portfolio_loss_perc <dbl>,
      #   year_of_shock <dbl>, duration_of_shock <dbl>, production_shock_perc <lgl>
      


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
      

# avoids overwritting output from a prevoius run

    This directory must not exist but it does:
    /home/mauro/pacta_tmp/output/working_dir/40_Results/TestPortfolio_Input


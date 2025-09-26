*AEA Model Baseline Level of Industrial Firm Contracts 


*21st December 2013 to 14th January 2014


*Based on the new formulation for the IEEE revision that accounts for proximity.


*Adjust the set of proximate junctions "m_prox(m)" based on: (I) Case B (accounts for all directly connected junctions)


*(II) Case A (only restricted to the specific junction)


*Uses a VoLL of 13,581 $/MWh which is in line with the Brattle report


*Lower bound on the firm power plant gas consumption LDC and NON-LDC


*Adds an exchange constraint (additional gas deliveries to firm power plants (AEA - Baseline) = reduced gas deliveries to industrial customers (Baseline - AEA))




****---------DEFINE ALL THE SETS IN THE MODEL------------------*****************
*Define a set of natural gas junctions:
Set    m      'gas junction nodes'
       / 1, 2, 5, 7, 8, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20
         21, 22, 24, 25, 27, 28, 29, 30, 31, 32, 34, 36, 37, 39, 40,
         41, 42, 44, 46, 48, 49, 50, 52, 53, 54, 56, 57, 58, 59, 61,
         63, 64, 65, 66, 67, 68, 69, 70, 71, 73, 75, 76, 77, 79, 81,
         82, 83, 86, 87, 89, 91, 93, 94, 96, 97, 99, 101, 102, 103, 104,
         105 /;
         

*Define the set of gas junctions in close proximity: 
Set    m_prox(m) 'gas junctions which are in close proximity to gas-fired generators (firm contracts)'
       / 12,13,14,15,18,21,28,29,30,31,32,34,44,46,48,49,50,53,59,64,65,67,82,83,86,87,89,91,93,97,99,101,102 /;
       

*Define the set of gas junctions not in close proximity:
Set   m_nonprox(m) 'gas junctions not in close proximity to gas-fired generators (firm contracts)';


m_nonprox(m) = yes$(not m_prox(m));



*Set of days surrounding the Polar Vortex:
Set D         'set of days' /D1*D25/;


*Transco Zone-6 gas junctions:
Set Transco_junc_set(m) 'gas junctions in Transco'

/ 5,7,11,12,13,14,15,18,19,20,21,29,30,31,32,34,50,56,91,93 /;


*Leidy gas junctions:
Set Leidy_junc_set(m) 'gas junctions in Leidy'

/1,2,8,10,17,22,24,25,27,28,36,37,39,40,41,42,44,46,48,49,75,76,77,79,81,103,
104 /;


*Algonquin gas junctions:
Set Algonquin_junc_set(m) 'gas junctions in Algonquin'

/ 52,53,54,57,58,59,61,63,64,65,66,67,68,69,70,96 /;


*Iroquois gas junctions:
Set Iroquois_junc_set(m) 'gas junctions in Iroquois'

/ 71,73,82,83,86,87,89,94,97,99,101,102,105 /;



*Set of gas junctions with LDC Firm Gas-Fired Generators:
Set gas_gen_LDC_firm_junc(m) 'gas junctions with LDC Firm Gas-Fired Generators'

/ 29,14,82,64,99,48 /;


*Set of gas junctions with LDC Firm Gas-Fired Generators (Transco):
Set gas_gen_LDC_firm_junc_Transco(m) 'gas junctions with LDC Firm Gas-Fired Generators in Transco'
/14, 29 /;

*Set of gas junctions with LDC Firm Gas-Fired Generators (Leidy):
Set gas_gen_LDC_firm_junc_Leidy(m) 'gas junctions with LDC Firm Gas-Fired Generators in Leidy'
/ 48 /;


*Set of gas junctions with LDC Firm Gas-Fired Generators (Algonquin):
Set gas_gen_LDC_firm_junc_Algonquin(m) 'gas junctions with LDC Firm Gas-Fired Generators in Algonquin'
/ 64 /;

*Set of gas junctions with LDC Firm Gas-Fired Generators (Iroquois):
Set gas_gen_LDC_firm_junc_Iroquois(m) 'gas junctions with LDC Firm Gas-Fired Generators in Iroquois'
/82, 99 /;


*Set of gas junctions with NON-LDC Firm Gas-Fired Generators:
Set gas_gen_NON_LDC_firm_junc(m) 'gas junctions with NON LDC Firm Gas-Fired Generators'

/ 86,29,93,34,31,64,44 /;

*Set of gas junctions with NON-LDC Firm Gas-Fired Generators (Transco):
Set gas_gen_NON_LDC_firm_junc_Transco(m) 'gas junctions with NON LDC Firm Gas-Fired Generators'
/29, 31, 34/;

*Set of gas junctions with NON-LDC Firm Gas-Fired Generators (Leidy):
Set gas_gen_NON_LDC_firm_junc_Leidy(m) 'gas junctions with NON LDC Firm Gas-Fired Generators'
/44/;

*Set of gas junctions with NON-LDC Firm Gas-Fired Generators (Algonquin):
Set gas_gen_NON_LDC_firm_junc_Algonquin(m) 'gas junctions with NON LDC Firm Gas-Fired Generators'
/64/;

*Set of gas junctions with NON-LDC Firm Gas-Fired Generators (Iroquois):
Set gas_gen_NON_LDC_firm_junc_Iroquois(m) 'gas junctions with NON LDC Firm Gas-Fired Generators'
/86,93/;


*Set of gas junctions with NON-LDC Interruptible Gas-Fired Generators:
Set gas_gen_NON_LDC_int_junc(m) 'gas junctions with NON LDC Int Gas-Fired Generators'

/ 63,76,66,19,71,91,34,87,21,86 /;



*Set of gas junctions with gas-fired generators connected to LDC and Pipeline:
Set gas_gen_LDC_NON_LDC_firm_junc(m) 'gas junctions with both LDC Firm and NON-LDC Firm Gas-Fired Generators'

/ 29,64 /;



*Define the set of natural gas pipelines:
Set a          'arcs' / 1*92 /

*Bifurcate the natural gas pipelines into "active" and "passive" pipelines:
as(a)      'active pipelines (with compressors)'
ap(a)      'passive pipelines (without compressors)'
amn(a,m,m) 'pipeline junction connection description';



*Define an alias set of "m" as "n" for defining the pipeline connectivity description
Alias (m,n);



*Import gas pipeline data: Pipeline resistance (Ml) and Active/Passive (Act=1,0)
$include table_pipe_data_gasgrid.gms


*Separate the active and passive pipelines using the "act" parameter
amn(a,m,n) = pipe_data_gasgrid(a,m,n,'Mk');
as(a) = sum(amn(a,m,n), pipe_data_gasgrid(amn,'act'));
ap(a) = not as(a);


*Defining the power system dataset:
*Define the set of buses:
*Note that everything in the power system is normalized on a per 100 MWh basis
Set
bus   /1, 5028, 70002, 71786, 71797, 72926,
     73106, 73110, 73171, 73663, 74316, 74327,
     74341, 74344, 74347, 75050, 75403, 75405,
     76663, 77400, 77406, 77950, 78701, 78702,
     79578, 79581, 79583, 79584, 79800, 80001,
     80031, 80101, 80121, 81615, 84819, 87004 /;

*Define the set of generators:
Set
gen / 1, 2, 3, 4, 5, 8, 10, 11, 17, 23,
     24, 25, 26, 30, 31, 32, 37, 40, 45, 46,
     51, 52, 53, 59, 60, 66, 67, 72, 80, 81,
     90, 94, 99, 101, 103, 108, 109, 117, 122, 123,
    129, 130, 136, 142, 143, 149, 157, 164, 166, 171,
    173, 180, 185, 187, 189, 194, 197, 198, 205, 212,
    215, 218, 219, 225, 232, 239, 243, 246, 247, 249,
    250, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 2003, 2010,
    2017, 2024, 2031, 2045, 2052, 2059, 2066, 2094, 2101, 2157,
    2164 /;

*Define the connectivity between the buses and the generators:
Set
gen_bus_con(bus,gen) / 1.1, 1.2, 1.3, 1.4, 1.5,
                      5028.8, 5028.10, 5028.11,70002.17, 71786.23,
                      71786.24, 71786.25, 71786.26, 71797.30, 71797.31,
                      71797.32, 72926.37, 72926.40, 73106.45, 73106.46,
                      73110.51, 73110.52, 73110.53, 73171.59, 73171.60,
                      73663.66, 73663.67, 74316.72, 74327.80, 74327.81,
                      74341.90, 74344.94, 74347.99, 74347.101, 74347.103,
                      75050.108, 75050.109, 75403.117, 75405.122, 75405.123,
                      76663.129, 76663.130, 77400.136, 77406.142, 77406.143,
                      77950.149, 78701.157, 78702.164, 78702.166, 79578.171,
                      79578.173, 79581.180, 79583.185, 79583.187, 79583.189,
                      79584.194, 79800.197, 79800.198, 80001.205, 80031.212,
                      80031.215, 80101.218, 80101.219, 80121.225, 81615.232,
                      84819.239, 84819.243,87004.246, 87004.247, 87004.249,
                      87004.250, 5028.1000, 78701.1001, 71786.1002, 70002.1003,
                      75403.1004, 79583.1005, 74327.1006, 1.2003, 5028.2010,
                      70002.2017, 71786.2024, 71797.2031, 73106.2045,73110.2052,
                      73171.2059, 73663.2066, 74344.2094, 74347.2101, 78701.2157,
                      78702.2164   /;


*Define a set for the transmission lines:
Set
line / L1*L121 /;


*Classify the generators based on their fuel/technology type:

*----------------------Define a set for coal fired generators------------------*
Set coal_gen(gen) / 1, 8, 99, 197, 218, 225, 232, 239, 246 /;
*----------------------Define a set for hydro electric generators--------------*
Set hydro_gen(gen) / 5, 26, 40, 103, 117, 166, 173, 180, 187, 194, 215, 243, 250 /;
*----------------------Define a set of nuclear generators----------------------*
Set nuclear_gen(gen) / 2, 23, 30, 37, 51, 72, 142, 149, 198, 205, 212, 219, 247 /;
*----------------------Define a set of oil fired generators--------------------*
Set oil_gen(gen) / 4, 11, 25, 32, 46, 53, 60, 67, 81, 109, 123, 130, 249 /;
*--------------------Define a set of other generators-------------------------*
Set other_gen(gen) / 90, 189, 1000, 1001, 1002, 1003, 1004, 1005, 1006 /;
*----------------------Define a set of gas generators------------------*
Set gas_gen(gen) / 3,2003,2031,2024,10,17,66,2059,94,164,129,45,2066,143,2094,157,
52,2017,122,108,2164,185,31,59,80,2045,136,2052,2101,101,2010,171,2157,24 /;





*------Set of gas-fired generators LDC firm------------------------*
Set gas_gen_LDC_firm(gen) / 3,10,143,136,2052,2010,171,185 /;


*-----Set of gas-fired generators NON-LDC firm----------------------*
Set gas_gen_NON_LDC_firm(gen) / 164,2003,59,2066,2101,2059,52,101,122 /;


*-----Set of gas-fired generators NON-LDC int-----------------------*
Set gas_gen_NON_LDC_int(gen) / 31,129,2031,45,80,2024,2045,17,2094,66,157,94,2017,108,2157,2164,24 /;



*Define sets to define the connections between the gas-fired generators and
*gas junctions
Set
gas_gen_LDC_firm_junc_connec(gen,m)
/ 3.29,10.14,143.82,136.82,2052.64,2010.14,171.99,185.48 /;

Set
gas_gen_NON_LDC_firm_junc_connec(gen,m)
/ 164.86,2003.29,59.93,2066.34,2101.31,2059.93,52.64,101.31,122.44 /;

Set
gas_gen_NON_LDC_int_junc_connec(gen,m)
/ 31.63,129.76,2031.63,45.66,80.19,2024.66,2045.66,17.71,2094.91,66.34,157.87,
94.91,2017.71,108.21,2157.87,2164.86,24.66 /;



****---------DEFINE ALL THE PARAMETERS IN THE MODEL------------------***********

*table name is "junc_data_gasgrid"
*Contains gas supply lower and upper bounds and
*Lower and Upper bounds on the junction pressure values
$include table_junc_data_gasgrid.gms



*Residential and Commercial Firm Demand:
Parameter pRC_firm_demand_PV(m,D);
$call gdxxrw.exe Junction_level_RC_demand_PV_import.xlsx par=pRC_firm_demand_PV rng=Sheet1!a1 rdim=1 cdim=1
$gdxin Junction_level_RC_demand_PV_import.gdx
$load pRC_firm_demand_PV
$gdxin


*Gas-fired power plants LDC Firm Contract Levels:
Parameter pLDC_PP_firm_contract_level(m);
$call gdxxrw.exe Junction_firm_gas_demand_contract_data_input_revised.xlsx par=pLDC_PP_firm_contract_level rng=PP_LDC_firm_contract!a1 rdim=1
$gdxin Junction_firm_gas_demand_contract_data_input_revised.gdx
$load pLDC_PP_firm_contract_level
$gdxin



*Gas-fired power plants NON-LDC Firm Contract Levels:
Parameter pNON_LDC_PP_firm_contract_level(m);
$call gdxxrw.exe Junction_firm_gas_demand_contract_data_input_revised.xlsx par=pNON_LDC_PP_firm_contract_level rng=PP_NON_LDC_firm_contract!a1 rdim=1
$gdxin Junction_firm_gas_demand_contract_data_input_revised.gdx
$load pNON_LDC_PP_firm_contract_level
$gdxin



*Industrial customers LDC Firm Contract Levels:
Parameter pLDC_Ind_firm_contract_level(m);
$call gdxxrw.exe Junction_firm_gas_demand_contract_data_input_revised.xlsx par=pLDC_Ind_firm_contract_level rng=Ind_LDC_firm_contract!a1 rdim=1
$gdxin Junction_firm_gas_demand_contract_data_input_revised.gdx
$load pLDC_Ind_firm_contract_level
$gdxin



*Industrial customers NON-LDC Firm Contract Levels:
Parameter pNON_LDC_Ind_firm_contract_level(m);
$call gdxxrw.exe Junction_firm_gas_demand_contract_data_input_revised.xlsx par=pNON_LDC_Ind_firm_contract_level rng=Ind_NON_LDC_firm_contract!a1 rdim=1
$gdxin Junction_firm_gas_demand_contract_data_input_revised.gdx
$load pNON_LDC_Ind_firm_contract_level
$gdxin



*Import the total junction power plant interruptible consumption limits:
Parameter pPP_int_cons_limits(m,D);
$call gdxxrw.exe input_baseline_parameters_for_AEA_model.xlsx par=pPP_int_cons_limits rng=PP_NONLDC_int_base!a1 rdim=1 cdim=1
$gdxin input_baseline_parameters_for_AEA_model.gdx
$load pPP_int_cons_limits
$gdxin


*Import the total junction power plant firm consumption LDC limits:
Parameter pPP_firm_cons_limits_LDC(m,D);
$call gdxxrw.exe input_baseline_parameters_for_AEA_model.xlsx par=pPP_firm_cons_limits_LDC rng=PP_LDC_firm_base!a1 rdim=1 cdim=1
$gdxin input_baseline_parameters_for_AEA_model.gdx
$load pPP_firm_cons_limits_LDC
$gdxin


*Import the total junction power plant firm consumption NON-LDC limits:
Parameter pPP_firm_cons_limits_NONLDC(m,D);
$call gdxxrw.exe input_baseline_parameters_for_AEA_model.xlsx par=pPP_firm_cons_limits_NONLDC rng=PP_NONLDC_firm_base!a1 rdim=1 cdim=1
$gdxin input_baseline_parameters_for_AEA_model.gdx
$load pPP_firm_cons_limits_NONLDC
$gdxin





*Import the total junction industrial firm gas consumption (LDC) limits (Baseline):
Parameter pInd_LDC_firm_cons_limits(m,D);
$call gdxxrw.exe input_baseline_parameters_for_AEA_model.xlsx par=pInd_LDC_firm_cons_limits rng=Ind_LDC_firm_base!a1 rdim=1 cdim=1
$gdxin input_baseline_parameters_for_AEA_model.gdx
$load pInd_LDC_firm_cons_limits
$gdxin



*Import the total junction industrial firm gas consumption (NON-LDC) limits (Baseline):
Parameter pInd_NONLDC_firm_cons_limits(m,D);
$call gdxxrw.exe input_baseline_parameters_for_AEA_model.xlsx par=pInd_NONLDC_firm_cons_limits rng=Ind_NONLDC_firm_base!a1 rdim=1 cdim=1
$gdxin input_baseline_parameters_for_AEA_model.gdx
$load pInd_NONLDC_firm_cons_limits
$gdxin



*Power plant interruptible consumption limits (upper bound): 
Parameter pPP_int_cons_limits_daily(m),

*Industrial firm consumption limits daily: 
pInd_LDC_firm_cons_limits_daily(m),
pInd_NONLDC_firm_cons_limits_daily(m),

*Power plant firm consumption limits daily (lower bound): 
pPP_LDC_firm_cons_limits_daily(m),
pPP_NONLDC_firm_cons_limits_daily(m);



**-------------Import the power system data-----------------------------------*


*---------Power Transmission line data (Max and Min) limits of lines "line_data":
*Table name is line_data(line, cap_limit)
$include line_data_gasgrid.gms


*-------------Get the PTDF factors for the line-------------------------------:
*Table name is PTDF_data(bus,line)
$include table_ptdf_data_gasgrid.gms


*--Generation data with maximum and minimum limits and fuel cost "gen_data":
*bus,
*Pmin,
*Pmax
*cost
$include gen_data_gasgrid.gms

*-------------Heat rate of the gas-fired generators-------------------------:
*Table is called: "nat_gen_heat_rate_data.gms"
$include nat_gen_data_gasgrid.gms



*Get the power system load data (per unit 100 MWs)--------------------------:
Parameter pPower_load_PV(bus,D);
$call gdxxrw.exe Electricity_load_demand_data_PV_import.xlsx par=pPower_load_PV rng=Sheet1!a1 rdim=1 cdim=1
$gdxin Electricity_load_demand_data_PV_import.gdx
$load pPower_load_PV
$gdxin


*Parameterize the ratio of Interruptible Industrial Gas Demand to
*Interruptible Power Plant Gas Demand (Pipeline)
Parameters
pTransco_ind_pp_int_demand_factor_PV(D),
pLeidy_ind_pp_int_demand_factor_PV(D),
pAlgonquin_ind_pp_int_demand_factor_PV(D),
pIroquois_ind_pp_int_demand_factor_PV(D);


$call gdxxrw.exe Industrial_power_plants_int_demand_factors_PV_import_revised.xlsx par=pTransco_ind_pp_int_demand_factor_PV rng=Transco_Zone_6!a1 rdim=0 cdim=1
$gdxin Industrial_power_plants_int_demand_factors_PV_import_revised.gdx
$load pTransco_ind_pp_int_demand_factor_PV
$gdxin


$call gdxxrw.exe Industrial_power_plants_int_demand_factors_PV_import_revised.xlsx par=pLeidy_ind_pp_int_demand_factor_PV rng=Leidy!a1 rdim=0 cdim=1
$gdxin Industrial_power_plants_int_demand_factors_PV_import_revised.gdx
$load pLeidy_ind_pp_int_demand_factor_PV
$gdxin



$call gdxxrw.exe Industrial_power_plants_int_demand_factors_PV_import_revised.xlsx par=pAlgonquin_ind_pp_int_demand_factor_PV rng=Algonquin!a1 rdim=0 cdim=1
$gdxin Industrial_power_plants_int_demand_factors_PV_import_revised.gdx
$load pAlgonquin_ind_pp_int_demand_factor_PV
$gdxin



$call gdxxrw.exe Industrial_power_plants_int_demand_factors_PV_import_revised.xlsx par=pIroquois_ind_pp_int_demand_factor_PV rng=Iroquois!a1 rdim=0 cdim=1
$gdxin Industrial_power_plants_int_demand_factors_PV_import_revised.gdx
$load pIroquois_ind_pp_int_demand_factor_PV
$gdxin



*Define the penalty in line with the Brattle report of 13,581 $/MWh for ERCOT for a 16 hour outage:
*https://www.brattle.com/wp-content/uploads/2024/09/Value-of-Lost-Load-Study-for-the-ERCOT-Region.pdf

Parameter pPower_unserved_penalty / 13581 /;



*Scaling factor on firm industrial gas demand that is shed:
Parameter E_I / 0.1 /;



*Import the daily spot gas prices by zone:
Parameters pTransco_price_PV(D),
pLeidy_price_PV(D),
pAlgonquin_price_PV(D),
pIroquois_price_PV(D);


$call gdxxrw.exe Spot_price_data_PV_import.xlsx par=pTransco_price_PV rng=Transco_Z6!a1 rdim=0 cdim=1
$gdxin Spot_price_data_PV_import.gdx
$load pTransco_price_PV
$gdxin

$call gdxxrw.exe Spot_price_data_PV_import.xlsx par=pLeidy_price_PV rng=Leidy!a1 rdim=0 cdim=1
$gdxin Spot_price_data_PV_import.gdx
$load pLeidy_price_PV
$gdxin

$call gdxxrw.exe Spot_price_data_PV_import.xlsx par=pAlgonquin_price_PV rng=Algonquin!a1 rdim=0 cdim=1
$gdxin Spot_price_data_PV_import.gdx
$load pAlgonquin_price_PV
$gdxin


$call gdxxrw.exe Spot_price_data_PV_import.xlsx par=pIroquois_price_PV rng=Iroquois!a1 rdim=0 cdim=1
$gdxin Spot_price_data_PV_import.gdx
$load pIroquois_price_PV
$gdxin



*1. Define the electrical load demand placeholder parameters:
Parameter pPower_load(bus);



*2. Define the RC gas demand placeholder parameter:
Parameter pRC_firm_demand(m);



*3. Define the spot gas price placeholder parameter:
Parameters pTransco_price,
pLeidy_price,
pAlgonquin_price,
pIroquois_price;


*4. Define the interruptible gas demand factor parameters:
Parameters
pTransco_ind_pp_int_demand_factor,
pLeidy_ind_pp_int_demand_factor,
pAlgonquin_ind_pp_int_demand_factor,
pIroquois_ind_pp_int_demand_factor;


*Define the variables for the model:
Variables
vPg(gen) 'Generator Output',
vinjection(bus) 'Nodal Power injection at bus',
vflow_line(line) 'Power flow on the transmission line',

vf(a,m,n) 'flow on the pipeline from the junction m to junction n'
vs(m)    'Gas supply at junction m'
vpi(m)   'Pressure squared value at junction m';

Variables
vsys_obj;


Positive variables
vunserved_load(bus) 'Unserved electrical load at a particular bus',

vgen_pp_LDC_firm_gas_cons(gen),
vjunc_pp_LDC_firm_gas_cons(m),

vgen_pp_NON_LDC_firm_gas_cons(gen),
vjunc_pp_NON_LDC_firm_gas_cons(m),

vgen_pp_NON_LDC_int_gas_cons(gen),
vjunc_pp_NON_LDC_int_gas_cons(m),

vjunc_ind_LDC_firm_gas_cons(m),
vjunc_ind_NON_LDC_firm_gas_cons(m),
vjunc_ind_NON_LDC_int_gas_cons(m),



v_int_pp_demand_Transco,
v_int_pp_demand_Leidy,
v_int_pp_demand_Algonquin,
v_int_pp_demand_Iroquois,

v_int_pp_demand_Transco_cost,
v_int_pp_demand_Leidy_cost,
v_int_pp_demand_Algonquin_cost,
v_int_pp_demand_Iroquois_cost,

vslack(m);



*Define the equations in the model
Equations
*edummy_obj,
esys_obj,
**---------------------Power system equations---------------------------*
*Nodal supply demand balance equation:
enode_balance(bus) 'Node balance equation',
*System supply demand balance constraint:
esystem_balance 'System balance constraint',
*Transmission line flow equation:
eline_flows(line) 'Equation calculating the transmission line flow',
*Transmission line flow lower bounds:
eline_flows_lower(line) 'Equation establishing the lower bound on the transmission line flow',
*Transmission line flow upper bounds:
eline_flows_upper(line) 'Equation establishing the upper bound on the transmission line flow',
*Generation lower bound:
egen_lower(gen) 'Equation establishing the lower bound on the generator output',
*Generation upper bound:
egen_upper(gen) 'Equation establishing the upper bound on the generator output',



**-----------------Coupling equations-----------------------------------*
*-----Calculate the consumption of LDC gas-fired generators with firm contracts:
ecouple_PP_LDC_Firm(gen),
*Set the consumption to zero to generators that are not(LDC gas-fired generators with firm contracts)
ecouple_PP_LDC_Firm_set_zero(gen),
*Calculate the consumption of LDC gas-fired generators at the junction-level:
ecouple_PP_LDC_Firm_junc_level(m),
*Set the consumption to zero at gas junctions without LDC gas-fired generators:
ecouple_PP_LDC_Firm_junc_level_set_zero(m),
*Bound the consumption by the amount of firm contracts:
ecouple_PP_LDC_Firm_junc_level_upper(m),



*-----Calculate the consumption of NON-LDC (Pipeline) gas-fired generators with firm contracts:
ecouple_PP_NON_LDC_Firm(gen),
*Set the consumption to zero to generators that are not(NON-LDC gas-fired generators with firm contracts)
ecouple_PP_NON_LDC_Firm_set_zero(gen),
*Calculate the consumption of NON-LDC gas-fired generators firm contracts at the junction-level:
ecouple_PP_NON_LDC_Firm_junc_level(m),
*Set the consumption to zero at gas junctions without NON-LDC gas-fired generators:
ecouple_PP_NON_LDC_Firm_junc_level_set_zero(m),
*Bound the consumption by the amount of firm contracts:
ecouple_PP_NON_LDC_Firm_junc_level_upper(m),





*-----Calculate the consumption of NON-LDC (Pipeline) gas-fired generators with interruptible contracts:
ecouple_PP_NON_LDC_Int(gen),
*Set the consumption to zero to generators that are not(NON-LDC gas-fired generators with interruptible contracts)
ecouple_PP_NON_LDC_Int_set_zero(gen),
*Calculate the consumption of NON-LDC gas-fired generators interruptible contracts at the junction-level:
ecouple_PP_NON_LDC_Int_junc_level(m),
*Set the consumption to zero at gas junctions without NON-LDC gas-fired generators with interruptible contracts:
ecouple_PP_NON_LDC_Int_junc_level_set_zero(m),


*---------Equations for calculating the cost of gas procured through spot market'
*------by gas-fired generators with interruptible contracts--------------------*
eflex_Transco,
eflex_Leidy,
eflex_Algonquin,
eflex_Iroquois,

ecost_Transco,
ecost_Leidy,
ecost_Algonquin,
ecost_Iroquois,


*-----------------------Pipeline flow equations------------------------------*
*Passive pipeline:
eweymouthp(a,m,n),
*Active pipeline:
eweymoutha(a,m,n),
*Active pipeline flow bound:
eweymoutha_flow_bound(a,m,n),


*---------------Supply demand balance constraint junction--------------------*
eflowbalance(m),


*Linking constraints industrial customers and power plants (Interruptible contracts)-------------------*
enon_NON_LDC_PP_Ind_Int_link_Transco,
enon_NON_LDC_PP_Ind_Int_link_Leidy,
enon_NON_LDC_PP_Ind_Int_link_Algonquin,
enon_NON_LDC_PP_Ind_Int_link_Iroquois,




*Constraints on upper bounds on firm and interruptible consumption by junction (Baseline model bounds):
ejunc_int_pp_reliability_limits_lower(m),
ejunc_int_pp_reliability_limits_upper(m), 


*Constraints on firm industrial gas consumption (Baseline model bounds): 
ejunc_firm_ind_LDC_limits_lower_prox(m),
ejunc_firm_ind_LDC_limits_upper_prox(m),
ejunc_firm_ind_LDC_limits_lower_nonprox(m),
ejunc_firm_ind_LDC_limits_upper_nonprox(m),


ejunc_firm_ind_NONLDC_limits_lower_prox(m),
ejunc_firm_ind_NONLDC_limits_upper_prox(m),
ejunc_firm_ind_NONLDC_limits_lower_nonprox(m),
ejunc_firm_ind_NONLDC_limits_upper_nonprox(m),


*Constraints on the power plant gas consumption lower bound:
ejunc_firm_pp_LDC_limits_lower(m),
ejunc_firm_pp_NONLDC_limits_lower(m),


*Place a constraint on the reallocation: Additional gas deliveries to power plants (firm) = Reduced gas deliveries to industrial customers (firm):
eexchange_constraint_aggregate,

*Additional gas deliveries to the power plants (AEA v/s Baseline) should be non-negative  
eexchange_bound_pp,

*Reduced gas deliveries to the industrial customers (AEA v/s Baseline) should be non-negative 
eexchange_bound_ind; 

   



*------------------------------------------Power system equations-------------------------------------------*
*Nodal supply demand balance equation:
enode_balance(bus).. vinjection(bus) =e= sum(gen$(gen_bus_con(bus,gen)),vPg(gen)) + vunserved_load(bus) - pPower_load(bus);


*System supply demand balance equations:
esystem_balance.. sum(bus, vinjection(bus)) =e= 0;


*Transmission line flows:
eline_flows(line).. sum(bus, ((ptdf_data(bus,line)*(vinjection(bus))))) =e= vflow_line(line);


*Transmission line flow lower bounds:
eline_flows_lower(line)..  vflow_line(line) =g= -(line_data(line,'cap_limit'));


*Transmission line flow upper bounds:
eline_flows_upper(line)..  vflow_line(line) =l= (line_data(line,'cap_limit'));


*Generation lower bound:
egen_lower(gen).. vPg(gen) =g= gen_data(gen,'pmin');


*Generation upper bound:
egen_upper(gen).. vPg(gen) =l= gen_data(gen,'pmax');



*-------------------------------------Coupling equations---------------------------------------------------*
*-----Power plant LDC Firm Gas Consumption Equations----------------------------*
ecouple_PP_LDC_Firm(gen)$(gas_gen_LDC_firm(gen)).. vPg(gen)*nat_gen_heat_rate_data(gen,'h') =e= vgen_pp_LDC_firm_gas_cons(gen);

ecouple_PP_LDC_Firm_set_zero(gen)$(not(gas_gen_LDC_firm(gen))).. vgen_pp_LDC_firm_gas_cons(gen) =e= 0;

ecouple_PP_LDC_Firm_junc_level(m)$(gas_gen_LDC_firm_junc(m)).. sum(gen$(gas_gen_LDC_firm_junc_connec(gen,m)), vgen_pp_LDC_firm_gas_cons(gen)) =e= vjunc_pp_LDC_firm_gas_cons(m);

ecouple_PP_LDC_Firm_junc_level_set_zero(m)$(not(gas_gen_LDC_firm_junc(m))).. vjunc_pp_LDC_firm_gas_cons(m) =e= 0;

ecouple_PP_LDC_Firm_junc_level_upper(m)$(gas_gen_LDC_firm_junc(m)).. vjunc_pp_LDC_firm_gas_cons(m) =l=  pLDC_PP_firm_contract_level(m);


*-----Power plant NON-LDC Firm Gas Consumption Equations----------------------------*
ecouple_PP_NON_LDC_Firm(gen)$(gas_gen_NON_LDC_firm(gen)).. vPg(gen)*nat_gen_heat_rate_data(gen,'h') =e= vgen_pp_NON_LDC_firm_gas_cons(gen);

ecouple_PP_NON_LDC_Firm_set_zero(gen)$(not(gas_gen_NON_LDC_firm(gen))).. vgen_pp_NON_LDC_firm_gas_cons(gen) =e= 0;

ecouple_PP_NON_LDC_Firm_junc_level(m)$(gas_gen_NON_LDC_firm_junc(m)).. sum(gen$(gas_gen_NON_LDC_firm_junc_connec(gen,m)), vgen_pp_NON_LDC_firm_gas_cons(gen)) =e= vjunc_pp_NON_LDC_firm_gas_cons(m);

ecouple_PP_NON_LDC_Firm_junc_level_set_zero(m)$(not(gas_gen_NON_LDC_firm_junc(m))).. vjunc_pp_NON_LDC_firm_gas_cons(m) =e= 0;

ecouple_PP_NON_LDC_Firm_junc_level_upper(m)$(gas_gen_NON_LDC_firm_junc(m)).. vjunc_pp_NON_LDC_firm_gas_cons(m) =l=  pNON_LDC_PP_firm_contract_level(m);


*-----Power plant NON-LDC Interruptible Gas Consumption Equations----------------------------*
ecouple_PP_NON_LDC_Int(gen)$(gas_gen_NON_LDC_int(gen)).. vPg(gen)*nat_gen_heat_rate_data(gen,'h') =e= vgen_pp_NON_LDC_int_gas_cons(gen);

ecouple_PP_NON_LDC_Int_set_zero(gen)$(not(gas_gen_NON_LDC_int(gen))).. vgen_pp_NON_LDC_int_gas_cons(gen) =e= 0;

ecouple_PP_NON_LDC_Int_junc_level(m)$(gas_gen_NON_LDC_int_junc(m)).. sum(gen$(gas_gen_NON_LDC_int_junc_connec(gen,m)), vgen_pp_NON_LDC_int_gas_cons(gen)) =e= vjunc_pp_NON_LDC_int_gas_cons(m);

ecouple_PP_NON_LDC_Int_junc_level_set_zero(m)$(not(gas_gen_NON_LDC_int_junc(m))).. vjunc_pp_NON_LDC_int_gas_cons(m) =e= 0;




*----Equations for zonal spot gas cost functions-------------------------------*
eflex_Transco.. sum(m$(Transco_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m)) =e= v_int_pp_demand_Transco;

eflex_Leidy.. sum(m$(Leidy_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m)) =e= v_int_pp_demand_Leidy;

eflex_Algonquin.. sum(m$(Algonquin_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m)) =e= v_int_pp_demand_Algonquin;

eflex_Iroquois.. sum(m$(Iroquois_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m)) =e= v_int_pp_demand_Iroquois;


ecost_Transco.. v_int_pp_demand_Transco_cost =g= pTransco_price *v_int_pp_demand_Transco;

ecost_Leidy.. v_int_pp_demand_Leidy_cost =g= pLeidy_price *v_int_pp_demand_Leidy;

ecost_Algonquin.. v_int_pp_demand_Algonquin_cost =g= pAlgonquin_price *v_int_pp_demand_Algonquin;

ecost_Iroquois.. v_int_pp_demand_Iroquois_cost =g= pIroquois_price *v_int_pp_demand_Iroquois;


*Flow Equation passive pipeline:
eweymouthp(amn(ap,m,n)).. signpower(vf(amn),2) =e= (pipe_data_gasgrid(amn,'Mk'))*(vpi(m)-vpi(n));

*Flow equation active pipeline:
eweymoutha(amn(as,m,n)).. vf(amn)*vf(amn) =g= (pipe_data_gasgrid(amn,'Mk'))*(vpi(m)-vpi(n));

*Flow equation active pipeline:
eweymoutha_flow_bound(amn(as,m,n)).. vf(amn) =g= 0;


*Supply demand balance constraint at the gas junction:
eflowbalance(m)..  (sum(amn(a,n,m), vf(amn))) + vs(m) + vslack(m) =e= ((sum(amn(a,m,n), vf(amn)))) + pRC_firm_demand(m) + vjunc_pp_LDC_firm_gas_cons(m) + vjunc_pp_NON_LDC_firm_gas_cons(m) + vjunc_pp_NON_LDC_int_gas_cons(m) + vjunc_ind_LDC_firm_gas_cons(m) + vjunc_ind_NON_LDC_firm_gas_cons(m) + vjunc_ind_NON_LDC_int_gas_cons(m);


*Linking constraints between power plants and industrial gas consumption (Firm contracts):
enon_NON_LDC_PP_Ind_Int_link_Transco.. sum(m$(Transco_junc_set(m)), vjunc_ind_NON_LDC_int_gas_cons(m)) =e= pTransco_ind_pp_int_demand_factor*sum(m$(Transco_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m));


enon_NON_LDC_PP_Ind_Int_link_Leidy.. sum(m$(Leidy_junc_set(m)), vjunc_ind_NON_LDC_int_gas_cons(m)) =e= pLeidy_ind_pp_int_demand_factor*sum(m$(Leidy_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m));


enon_NON_LDC_PP_Ind_Int_link_Algonquin.. sum(m$(Algonquin_junc_set(m)), vjunc_ind_NON_LDC_int_gas_cons(m)) =e= pAlgonquin_ind_pp_int_demand_factor*sum(m$(Algonquin_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m));


enon_NON_LDC_PP_Ind_Int_link_Iroquois.. sum(m$(Iroquois_junc_set(m)), vjunc_ind_NON_LDC_int_gas_cons(m)) =e= pIroquois_ind_pp_int_demand_factor*sum(m$(Iroquois_junc_set(m)), vjunc_pp_NON_LDC_int_gas_cons(m));


eexchange_constraint_aggregate.. sum(m, vjunc_pp_LDC_firm_gas_cons(m) + vjunc_pp_NON_LDC_firm_gas_cons(m)) - sum(m, pPP_LDC_firm_cons_limits_daily(m) + pPP_NONLDC_firm_cons_limits_daily(m)) =e= sum(m, pInd_LDC_firm_cons_limits_daily(m) + pInd_NONLDC_firm_cons_limits_daily(m)) - sum(m, vjunc_ind_LDC_firm_gas_cons(m) + vjunc_ind_NON_LDC_firm_gas_cons(m)); 


eexchange_bound_pp.. sum(m, vjunc_pp_LDC_firm_gas_cons(m) + vjunc_pp_NON_LDC_firm_gas_cons(m)) - sum(m, pPP_LDC_firm_cons_limits_daily(m) + pPP_NONLDC_firm_cons_limits_daily(m)) =g= 0; 


eexchange_bound_ind.. sum(m, pInd_LDC_firm_cons_limits_daily(m) + pInd_NONLDC_firm_cons_limits_daily(m)) - sum(m, vjunc_ind_LDC_firm_gas_cons(m) + vjunc_ind_NON_LDC_firm_gas_cons(m)) =g= 0;




*--------Define the objective function------------------------------------*
esys_obj.. vsys_obj =e=  
    (sum(gen, (vPg(gen)*gen_data(gen,'cost'))) 
    + sum(bus, (pPower_unserved_penalty*24*100*vunserved_load(bus))) 
    + v_int_pp_demand_Transco_cost 
    + v_int_pp_demand_Leidy_cost 
    + v_int_pp_demand_Algonquin_cost 
    + v_int_pp_demand_Iroquois_cost 
    + sum(m, vslack(m)*1000000000) 
    + (E_I*1241216.4816*(sum(m, pNON_LDC_Ind_firm_contract_level(m)-vjunc_ind_NON_LDC_firm_gas_cons(m)))) 
    + (E_I*1241216.4816*(sum(m, pLDC_Ind_firm_contract_level(m)-vjunc_ind_LDC_firm_gas_cons(m))))
    )/ 10000000;



*-------Constraints on interruptible power plants-----------------------------*
ejunc_int_pp_reliability_limits_lower(m)..   vjunc_pp_NON_LDC_int_gas_cons(m) =g= 0;
ejunc_int_pp_reliability_limits_upper(m)..   vjunc_pp_NON_LDC_int_gas_cons(m) =l= pPP_int_cons_limits_daily(m);


*------Constraints on firm industrial customers (LDC)-------------------------------*
*Proximate customers: 
ejunc_firm_ind_LDC_limits_lower_prox(m)$(m_prox(m))..
    vjunc_ind_LDC_firm_gas_cons(m) =g= 0;

ejunc_firm_ind_LDC_limits_upper_prox(m)$(m_prox(m))..
    vjunc_ind_LDC_firm_gas_cons(m) =l= pInd_LDC_firm_cons_limits_daily(m);

*Nonproximate customers:
ejunc_firm_ind_LDC_limits_lower_nonprox(m)$(m_nonprox(m))..
    vjunc_ind_LDC_firm_gas_cons(m) =g= pInd_LDC_firm_cons_limits_daily(m);

ejunc_firm_ind_LDC_limits_upper_nonprox(m)$(m_nonprox(m))..
    vjunc_ind_LDC_firm_gas_cons(m) =l= pInd_LDC_firm_cons_limits_daily(m);
    


*------Constraints on firm industrial customers (NON-LDC)-------------------------------*
*Proximate customers: 
ejunc_firm_ind_NONLDC_limits_lower_prox(m)$(m_prox(m))..
    vjunc_ind_NON_LDC_firm_gas_cons(m) =g= 0;

ejunc_firm_ind_NONLDC_limits_upper_prox(m)$(m_prox(m))..
   vjunc_ind_NON_LDC_firm_gas_cons(m) =l= pInd_NONLDC_firm_cons_limits_daily(m);

*Nonproximate customers:
ejunc_firm_ind_NONLDC_limits_lower_nonprox(m)$(m_nonprox(m))..
   vjunc_ind_NON_LDC_firm_gas_cons(m) =g= pInd_NONLDC_firm_cons_limits_daily(m); 

ejunc_firm_ind_NONLDC_limits_upper_nonprox(m)$(m_nonprox(m))..
   vjunc_ind_NON_LDC_firm_gas_cons(m) =l= pInd_NONLDC_firm_cons_limits_daily(m);
    

*Establish bounds on variables:
*The gas supply at a junction is to be bounded between the minimum and maximum values:
vs.lo(m)  = junc_data_gasgrid(m,'slo');
vs.up(m)  = junc_data_gasgrid(m,'sup');


*The pressure at the gas junction is to be bounded between the minimum and maximum values:
vpi.lo(m) = junc_data_gasgrid(m,'pmin')*junc_data_gasgrid(m,'pmin');
vpi.up(m) = junc_data_gasgrid(m,'pmax')*junc_data_gasgrid(m,'pmax');


*Industrial LDC and NON-LDC firm consumption
vjunc_ind_LDC_firm_gas_cons.up(m) = pLDC_Ind_firm_contract_level(m);

vjunc_ind_NON_LDC_firm_gas_cons.up(m) = pNON_LDC_Ind_firm_contract_level(m);



*Power plant lower bounds on the gas deliveries: 
ejunc_firm_pp_LDC_limits_lower(m).. vjunc_pp_LDC_firm_gas_cons(m) =g= pPP_LDC_firm_cons_limits_daily(m);   

ejunc_firm_pp_NONLDC_limits_lower(m).. vjunc_pp_NON_LDC_firm_gas_cons(m) =g= pPP_NONLDC_firm_cons_limits_daily(m);  


    
*Declare the model outside the loop:
Model AEA_model_baseline_ind_firm_contracts_only_firmpp_realloc / all /;



*Define the post processing parameters:
Parameters pModel_solution_stat(D);

*Get the fraction of unserved energy:
Parameters pfrac_unserved_electric_energy(D);

*Get the total unserved energy:
Parameters pUnserved_total(D);


*Get the total unserved electric energy (for a day by node):
Parameters pUnserved_node(bus, D);

 

*Get the generation by fuel type:
Parameters pCoal_gen_total(D), pHydro_gen_total(D), pNuclear_gen_total(D), pOil_gen_total(D),
pGas_gen_total(D);

*Get the capacity factor:
Parameters pCap_factor_coal_gen(D), pCap_factor_hydro_gen(D), pCap_factor_nuclear_gen(D),
pCap_factor_oil_gen(D);


*Gas-fired generation in GWh (Firm):
Parameters pGasgenLDC_firm(D), pGasgenNON_LDC_firm(D), pGasgenNON_LDC_int(D),
pGasgen_firm(D);


*Firm gas delivery by zone:
Parameters pTransco_firm_Ind_del(D), pLeidy_firm_Ind_del(D),
pLeidy_firm_Ind_del(D), pAlgonquin_firm_Ind_del(D), pIroquois_firm_Ind_del(D),
pTotal_firm_Ind_del(D), pFrac_ind_firm_served(D);



*Firm delivery to power plants by zone:
Parameters pLDC_firm_PP_delivery_Transco(D), pLDC_firm_PP_delivery_Leidy(D),
pLDC_firm_PP_delivery_Algonquin(D), pLDC_firm_PP_delivery_Iroquois(D);


*Firm delivery to power plants by zone:
Parameters pNONLDC_firm_PP_delivery_Transco(D), pNONLDC_firm_PP_delivery_Leidy(D),
pNONLDC_firm_PP_delivery_Algonquin(D),pNONLDC_firm_PP_delivery_Iroquois(D);


Parameters pPP_Frac_firm_contract_amounts(D);


Parameters pdispatch_cost_non_gas(D), pcost_pp_int_contracts(D),
pcost_unserved_electric_energy(D);


Parameters pdispatch_cost_non_gas_25days, pcost_pp_int_contracts_25days,
pcost_unserved_electric_energy_25days;


Parameters pUnserved_industrial_gas_demand_daily;


Parameters pTranscofirmPP(D), pLeidyfirmPP(D),  pAlgonquinfirmPP(D),
pIroquoisfirmPP(D);


Parameters pTransco_PP_int_gas_demand(D), pLeidy_PP_int_gas_demand(D),
pAlgonquin_PP_int_gas_demand(D), pIroquois_PP_int_gas_demand(D);


Parameters pJuncFirmPPgasdel(m,D), pJuncIntPPgasdel(m,D);


Parameters pGentotalfirm, PGentotalint, PGentotaloil;


Parameters pAdditionalgasdelpowerplants_daily(D); 



Parameters pAdditionalgasdelpowerplants;




Set D_unserved(D)

/ D12, D13, D14, D15, D17, D18, D19, D20 /;


Parameters 
*Calculate the costs on days with unserved electric energy: 
pdispatch_cost_non_gas_unserved_days(D),
pcost_pp_int_contracts_unserved_days(D),
pcost_unserved_electric_unserved_days(D);



Parameters
*Calculate the industrial firm gas demand reallocated in comparison to the Baseline:
pfirmindreallocated_baseline(D);



loop(D,
*****------------Import the parameters for every day-------------------------*
*1. Change the electrical load demand placeholder parameters based on the day:
pPower_load(bus) = pPower_load_PV(bus,D);

*2. Define the RC gas demand placeholder parameters based on the day:
pRC_firm_demand(m) = pRC_firm_demand_PV(m,D);

*3. Define the spot gas price placeholder parameters based on the day:
pTransco_price = pTransco_price_PV(D);
pLeidy_price = pLeidy_price_PV(D);
pAlgonquin_price = pAlgonquin_price_PV(D);
pIroquois_price = pIroquois_price_PV(D);

*4. Define the interruptible gas demand factor parameters based on the day:
*Parameters
pTransco_ind_pp_int_demand_factor = pTransco_ind_pp_int_demand_factor_PV(D);
pLeidy_ind_pp_int_demand_factor = pLeidy_ind_pp_int_demand_factor_PV(D);
pAlgonquin_ind_pp_int_demand_factor = pAlgonquin_ind_pp_int_demand_factor_PV(D);
pIroquois_ind_pp_int_demand_factor =  pIroquois_ind_pp_int_demand_factor_PV(D);


*5. Power plant interruptible limits:
pPP_int_cons_limits_daily(m) = pPP_int_cons_limits(m,D);

*6. Industrial firm limits LDC baseline:
pInd_LDC_firm_cons_limits_daily(m) = pInd_LDC_firm_cons_limits(m,D);

*7. Industrial firm limits NONLDC baseline:
pInd_NONLDC_firm_cons_limits_daily(m) = pInd_NONLDC_firm_cons_limits(m,D);


*8. Power plant firm lower consumption limits baseline:
pPP_LDC_firm_cons_limits_daily(m) = pPP_firm_cons_limits_LDC(m,D);
pPP_NONLDC_firm_cons_limits_daily(m) = pPP_firm_cons_limits_NONLDC(m,D);





Options solver=CONOPT4;


Solve AEA_model_baseline_ind_firm_contracts_only_firmpp_realloc minimizing vsys_obj using NLP;


*****----------Save the post processing parameters----------------------------*
pModel_solution_stat(D) = AEA_model_baseline_ind_firm_contracts_only_firmpp_realloc.modelstat;


pfrac_unserved_electric_energy(D) = sum(bus, vunserved_load.l(bus))/sum(bus, pPower_load(bus));


pUnserved_total(D) = sum(bus, vunserved_load.l(bus))*2.4;


pUnserved_node(bus, D) = vunserved_load.l(bus)*2.4; 


* Calculate the generation and unserved energy from the different technology types (GWhs):
pCoal_gen_total(D) = sum(coal_gen(gen), vPg.l(gen))*2.4;

pHydro_gen_total(D) = sum(hydro_gen(gen), vPg.l(gen))*2.4;

pNuclear_gen_total(D) = sum(nuclear_gen(gen), vPg.l(gen))*2.4;

pGas_gen_total(D) = sum(gas_gen(gen), vPg.l(gen))*2.4;

pOil_gen_total(D) = sum(oil_gen(gen), vPg.l(gen))*2.4;

pUnserved_total(D) = sum(bus, vunserved_load.l(bus))*2.4;

*1. Calculate the capacity factors for the power plants (except gas-fired generators):

***----------------Coal-fired power plants-------------------------------------*
*Coal-fired power plants:
pCap_factor_coal_gen(D) = ((sum(coal_gen(gen), vPg.l(gen)))/(sum(coal_gen(gen), gen_data(gen,'pmax'))))*100;


***---------------Hydro power plants-------------------------------------------*
*Hydro power plants:
pCap_factor_hydro_gen(D) = ((sum(hydro_gen(gen), vPg.l(gen)))/(sum(hydro_gen(gen), gen_data(gen,'pmax'))))*100;


***---------------Nuclear power plants-----------------------------------------*
pCap_factor_nuclear_gen(D) = ((sum(nuclear_gen(gen), vPg.l(gen)))/(sum(nuclear_gen(gen), gen_data(gen,'pmax'))))*100;

***--------------Oil-fired power plants----------------------------------------*
pCap_factor_oil_gen(D) = ((sum(oil_gen(gen), vPg.l(gen)))/(sum(oil_gen(gen), gen_data(gen,'pmax'))))*100;


*Gas-fired generation in GWh (LDC Firm):
pGasgenLDC_firm(D) = sum(gen$(gas_gen_LDC_firm(gen)), vPg.l(gen))*2.4;

*Gas-fired generation in GWh (NON-LDC Firm):
pGasgenNON_LDC_firm(D) = sum(gen$(gas_gen_NON_LDC_firm(gen)), vPg.l(gen))*2.4;

*Gas-fired generation in GWh (NON-LDC Interruptible):
pGasgenNON_LDC_int(D) = sum(gen$(gas_gen_NON_LDC_int(gen)), vPg.l(gen))*2.4;


*Gas-fired generation in GWh (Firm):
pGasgen_firm(D) = pGasgenLDC_firm(D) + pGasgenNON_LDC_firm(D);


*Firm industrial gas delivery:
pTransco_firm_Ind_del(D) = sum(m$(Transco_junc_set(m)), vjunc_ind_NON_LDC_firm_gas_cons.l(m)) + sum(m$(Transco_junc_set(m)), vjunc_ind_LDC_firm_gas_cons.l(m));

pLeidy_firm_Ind_del(D) = sum(m$(Leidy_junc_set(m)), vjunc_ind_NON_LDC_firm_gas_cons.l(m)) + sum(m$(Leidy_junc_set(m)), vjunc_ind_LDC_firm_gas_cons.l(m));

pAlgonquin_firm_Ind_del(D) = sum(m$(Algonquin_junc_set(m)), vjunc_ind_NON_LDC_firm_gas_cons.l(m)) + sum(m$(Algonquin_junc_set(m)), vjunc_ind_LDC_firm_gas_cons.l(m));

pIroquois_firm_Ind_del(D) = sum(m$(Iroquois_junc_set(m)), vjunc_ind_NON_LDC_firm_gas_cons.l(m)) + sum(m$(Iroquois_junc_set(m)), vjunc_ind_LDC_firm_gas_cons.l(m));

*Total firm industrial gas delivery:
pTotal_firm_Ind_del(D) = pTransco_firm_Ind_del(D) + pLeidy_firm_Ind_del(D) +  pAlgonquin_firm_Ind_del(D) + pIroquois_firm_Ind_del(D);

*Fraction of total firm industrial customers served:
pFrac_ind_firm_served(D) = pTotal_firm_Ind_del(D)/sum(m, pLDC_Ind_firm_contract_level(m) + pNON_LDC_Ind_firm_contract_level(m));

*Gas delivery to LDC power plants as a ratio of their firm contracts:
pLDC_firm_PP_delivery_Transco(D) = ((sum(m$(gas_gen_LDC_firm_junc_Transco(m)), (vjunc_pp_LDC_firm_gas_cons.l(m))))/(sum(m$(gas_gen_LDC_firm_junc_Transco(m)), pLDC_PP_firm_contract_level(m))));
pLDC_firm_PP_delivery_Leidy(D) = ((sum(m$(gas_gen_LDC_firm_junc_Leidy(m)), (vjunc_pp_LDC_firm_gas_cons.l(m))))/(sum(m$(gas_gen_LDC_firm_junc_Leidy(m)), pLDC_PP_firm_contract_level(m))));
pLDC_firm_PP_delivery_Algonquin(D) = ((sum(m$(gas_gen_LDC_firm_junc_Algonquin(m)), (vjunc_pp_LDC_firm_gas_cons.l(m))))/(sum(m$(gas_gen_LDC_firm_junc_Algonquin(m)), pLDC_PP_firm_contract_level(m))));
pLDC_firm_PP_delivery_Iroquois(D) = ((sum(m$(gas_gen_LDC_firm_junc_Iroquois(m)), (vjunc_pp_LDC_firm_gas_cons.l(m))))/(sum(m$(gas_gen_LDC_firm_junc_Iroquois(m)), pLDC_PP_firm_contract_level(m))));


*Gas delivey to NON-LDC power plants as a ratio of their firm contracts:
pNONLDC_firm_PP_delivery_Transco(D) = ((sum(m$(Transco_junc_set(m)), vjunc_pp_NON_LDC_firm_gas_cons.l(m)))/(sum(m$(Transco_junc_set(m)), pNON_LDC_pp_firm_contract_level(m))));
pNONLDC_firm_PP_delivery_Leidy(D) = ((sum(m$(Leidy_junc_set(m)), vjunc_pp_NON_LDC_firm_gas_cons.l(m)))/(sum(m$(Leidy_junc_set(m)), pNON_LDC_pp_firm_contract_level(m))));
pNONLDC_firm_PP_delivery_Algonquin(D) = ((sum(m$(Algonquin_junc_set(m)), vjunc_pp_NON_LDC_firm_gas_cons.l(m)))/(sum(m$(Algonquin_junc_set(m)), pNON_LDC_pp_firm_contract_level(m))));
pNONLDC_firm_PP_delivery_Iroquois(D) = ((sum(m$(Iroquois_junc_set(m)), vjunc_pp_NON_LDC_firm_gas_cons.l(m)))/(sum(m$(Iroquois_junc_set(m)), pNON_LDC_pp_firm_contract_level(m))));


pPP_Frac_firm_contract_amounts(D) = (sum(m, vjunc_pp_LDC_firm_gas_cons.l(m) +  vjunc_pp_NON_LDC_firm_gas_cons.l(m)))/(sum(m, pLDC_PP_firm_contract_level(m) + pNON_LDC_pp_firm_contract_level(m)));


pdispatch_cost_non_gas(D) = (sum(gen, (vPg.l(gen)*gen_data(gen,'cost'))))/1000000;


pcost_pp_int_contracts(D) = (v_int_pp_demand_Transco_cost.l + v_int_pp_demand_Leidy_cost.l + v_int_pp_demand_Algonquin_cost.l + v_int_pp_demand_Iroquois_cost.l)/1000000;


pcost_unserved_electric_energy(D) = (sum(bus, (pPower_unserved_penalty*24*100*vunserved_load.l(bus))))/1000000;


*Save the total unserved firm industrial gas demand:
pUnserved_industrial_gas_demand_daily(D) = sum(m, pLDC_Ind_firm_contract_level(m) + pNON_LDC_Ind_firm_contract_level(m)) - sum(m, vjunc_ind_LDC_firm_gas_cons.l(m) + vjunc_ind_NON_LDC_firm_gas_cons.l(m));


pTranscofirmPP(D) = sum(m$(Transco_junc_set(m)),  vjunc_pp_LDC_firm_gas_cons.l(m) + vjunc_pp_NON_LDC_firm_gas_cons.l(m));

pLeidyfirmPP(D) = sum(m$(Leidy_junc_set(m)),  vjunc_pp_LDC_firm_gas_cons.l(m) + vjunc_pp_NON_LDC_firm_gas_cons.l(m));

pAlgonquinfirmPP(D) = sum(m$(Algonquin_junc_set(m)),  vjunc_pp_LDC_firm_gas_cons.l(m) + vjunc_pp_NON_LDC_firm_gas_cons.l(m));

pIroquoisfirmPP(D) = sum(m$(Iroquois_junc_set(m)),  vjunc_pp_LDC_firm_gas_cons.l(m) + vjunc_pp_NON_LDC_firm_gas_cons.l(m));


*---------Transco-----------------------------------------------------------*
pTransco_PP_int_gas_demand(D) = v_int_pp_demand_Transco.l;

*---------Leidy-------------------------------------------------------------*
pLeidy_PP_int_gas_demand(D) = v_int_pp_demand_Leidy.l;

*---------Algonquin---------------------------------------------------------*
pAlgonquin_PP_int_gas_demand(D) = v_int_pp_demand_Algonquin.l;

*---------Iroquois---------------------------------------------------------*
pIroquois_PP_int_gas_demand(D) = v_int_pp_demand_Iroquois.l;


*---------Store the firm PP gas deliveries of the power plants------------*
pJuncFirmPPgasdel(m,D) = vjunc_pp_LDC_firm_gas_cons.l(m) + vjunc_pp_NON_LDC_firm_gas_cons.l(m);


pJuncIntPPgasdel(m,D) = vjunc_pp_NON_LDC_int_gas_cons.l(m);


*Calculate the firm industrial gas demand reallocated in comparison to the Baseline (In this case only firm power plants):
 
pfirmindreallocated_baseline(D) = sum(m, pInd_LDC_firm_cons_limits(m,D) + pInd_NONLDC_firm_cons_limits(m,D)) - sum(m, vjunc_ind_LDC_firm_gas_cons.l(m) + vjunc_ind_NON_LDC_firm_gas_cons.l(m)); 


*Calculate the additional gas deliveries to power plants:
pAdditionalgasdelpowerplants_daily(D) = sum(m, vjunc_pp_LDC_firm_gas_cons.l(m) + vjunc_pp_NON_LDC_firm_gas_cons.l(m)) - sum(m, pPP_firm_cons_limits_LDC(m,D) + pPP_firm_cons_limits_NONLDC(m,D)); 



);


pdispatch_cost_non_gas_unserved_days(D)$(D_unserved(D)) = pdispatch_cost_non_gas(D);
pcost_pp_int_contracts_unserved_days(D)$(D_unserved(D)) = pcost_pp_int_contracts(D);
pcost_unserved_electric_unserved_days(D)$(D_unserved(D)) = pcost_unserved_electric_energy(D);


pdispatch_cost_non_gas_unserved_days(D)$(not D_unserved(D)) = 0;
pcost_pp_int_contracts_unserved_days(D)$(not D_unserved(D)) = 0;
pcost_unserved_electric_unserved_days(D)$(not D_unserved(D)) = 0;




*Calculate the total costs over the 25 days:
pdispatch_cost_non_gas_25days = sum(D,  pdispatch_cost_non_gas(D));
pcost_pp_int_contracts_25days = sum(D,  pcost_pp_int_contracts(D));
pcost_unserved_electric_energy_25days = sum(D, pcost_unserved_electric_energy(D));


*Calculate the total generation over the 25 days:
pGentotalfirm = sum(D, pGasgen_firm(D));
PGentotalint = sum(D,  pGasgenNON_LDC_int(D));
PGentotaloil = sum(D,  pOil_gen_total(D));


Parameter pTotalUnservedEnergy25days;
pTotalUnservedEnergy25days = sum(D, pUnserved_total(D));


*Calculate the reduction in unserved energy in comparison to the baseline:
Parameter pReductionUnservedEnergy25days;
pReductionUnservedEnergy25days = 431.676 - pTotalUnservedEnergy25days;


Parameter pJuncFirmPPgasdeltotal;
pJuncFirmPPgasdeltotal = sum((m,D), pJuncFirmPPgasdel(m,D));


Parameter pJuncIntPPgasdeltotal;
pJuncIntPPgasdeltotal = sum((m,D), pJuncIntPPgasdel(m,D));


Parameter pFirmIndGasdemandserved25days;


pFirmIndGasdemandserved25days = sum(D, pTotal_firm_Ind_del(D));


Parameter pFirmIndGasdemandcurtailed25days;

pFirmIndGasdemandcurtailed25days = (25*sum(m, pLDC_Ind_firm_contract_level(m) + pNON_LDC_Ind_firm_contract_level(m))) - pFirmIndGasdemandserved25days;


Parameter pTranscofirmPP25days,
pLeidyfirmPP25days,
pAlgonquinfirmPP25days,
pIroquoisfirmPP25days;



pTranscofirmPP25days = sum(D, pTranscofirmPP(D));


pLeidyfirmPP25days = sum(D, pLeidyfirmPP(D));


pAlgonquinfirmPP25days = sum(D, pAlgonquinfirmPP(D));


pIroquoisfirmPP25days = sum(D, pIroquoisfirmPP(D));



Parameter pTranscoIntPP25days,
pLeidyIntPP25days,
pAlgonquinIntPP25days,
pIroquoisIntPP25days;


pTranscoIntPP25days = sum(D, pTransco_PP_int_gas_demand(D));


pLeidyIntPP25days = sum(D, pLeidy_PP_int_gas_demand(D));


pAlgonquinIntPP25days = sum(D, pAlgonquin_PP_int_gas_demand(D));


pIroquoisIntPP25days = sum(D, pIroquois_PP_int_gas_demand(D)); 



Parameter pPP_firm_served_25days;

pPP_firm_served_25days = pTranscofirmPP25days + pLeidyfirmPP25days + pAlgonquinfirmPP25days + pIroquoisfirmPP25days; 
 



Parameter pIndustrial_firm_reallocated_25days;



pIndustrial_firm_reallocated_25days = sum(D, pfirmindreallocated_baseline(D));



pAdditionalgasdelpowerplants = sum(D, pAdditionalgasdelpowerplants_daily(D)); 



Display pTotalUnservedEnergy25days, pReductionUnservedEnergy25days, pJuncFirmPPgasdeltotal,
pJuncIntPPgasdeltotal, pGentotalfirm, PGentotalint,  PGentotaloil,
pdispatch_cost_non_gas_25days, pcost_pp_int_contracts_25days,
pcost_unserved_electric_energy_25days, pFrac_ind_firm_served,
pFirmIndGasdemandserved25days,pUnserved_total,
pCoal_gen_total, pHydro_gen_total, pNuclear_gen_total, pOil_gen_total,
pGas_gen_total, pCap_factor_coal_gen, pCap_factor_hydro_gen,
pCap_factor_nuclear_gen,pCap_factor_oil_gen,
pGasgenLDC_firm, pGasgenNON_LDC_firm, pGasgen_firm, pGasgenNON_LDC_int,
pFirmIndGasdemandcurtailed25days, pTranscofirmPP, pLeidyfirmPP,  pAlgonquinfirmPP,
pIroquoisfirmPP,pTransco_PP_int_gas_demand, pLeidy_PP_int_gas_demand,
pAlgonquin_PP_int_gas_demand, pIroquois_PP_int_gas_demand,


pTranscoIntPP25days, pLeidyIntPP25days, pAlgonquinIntPP25days, pIroquoisIntPP25days, 



pdispatch_cost_non_gas, pcost_pp_int_contracts, pcost_unserved_electric_energy,


pdispatch_cost_non_gas_unserved_days, pcost_pp_int_contracts_unserved_days,
pcost_unserved_electric_unserved_days,


pfirmindreallocated_baseline,


pTranscofirmPP25days, pLeidyfirmPP25days, pAlgonquinfirmPP25days, pIroquoisfirmPP25days,


pIndustrial_firm_reallocated_25days,


pAdditionalgasdelpowerplants,


pAdditionalgasdelpowerplants_daily,


pFirmIndGasdemandserved25days,


pPP_firm_served_25days,


pUnserved_node;  




  













 




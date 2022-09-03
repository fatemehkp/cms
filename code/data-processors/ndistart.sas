/* Created by Fatemeh K (Re-Done 08-20-2022)																*/
/* Focus on 2000 (Jan) to 2008 data                                              					*/
/* Count total numbers and subgroups */


libname cms '/scratch/fatemehkp/projects/CMS/data/processed';
libname prcs1 '/scratch/fatemehkp/projects/Zipcode PM NO2/data/processed';   
libname prcs2 '/scratch/fatemehkp/projects/Zipcode Ozone PM/data/processed'; 
libname spt '/scratch/fatemehkp/projects/USA Spatial/data/processed';                                                  

/** Done;*/
/*proc sort data=cms.enrollee65_ndi_0008_clean;*/
/*	by bene_id year month; */
/*run;*/


/* beneficiries at time of enrollment */

* with pm data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and ses_zip ne .;
run;

proc sort data=master0 nodupkey out=prcs1.enrollee_pm_start;
	by bene_id; 
run;


* with no2 data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and no2_1yr ne . and ses_zip ne .;
run;

proc sort data=master0 nodupkey out=prcs1.enrollee_no2_start;
	by bene_id; 
run;

* with o3 data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and o3max8h_warm ne . and ses_zip ne .;
run;

proc sort data=master0 nodupkey out=prcs2.enrollee_o3_start;
	by bene_id; 
run;

* with pm and brfss data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and ses_zip ne . and X_bmi_mean ne .;
run;
	
proc sort data=master0 nodupkey out=prcs1.enrollee_pm_brfss_start;
	by bene_id; 
run;

* with no2 and brfss data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and no2_1yr ne . and ses_zip ne . and X_bmi_mean ne .;
run;
	
proc sort data=master0 nodupkey out=prcs1.enrollee_no2_brfss_start;
	by bene_id; 
run;

* with o3 and brfss data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and o3max8h_warm ne . and ses_zip ne . and X_bmi_mean ne .;
run;
	
proc sort data=master0 nodupkey out=prcs2.enrollee_o3_brfss_start;
	by bene_id; 
run;

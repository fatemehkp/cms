/* Created by Fatemeh K (02-11-2021)																*/
/* Focus on 2000 (Jan) to 2008 data                                              					*/
/* Count total numbers and subgroups */


libname cms '/scratch/fatemehkp/projects/CMS/data/processed';
libname prcs '/scratch/fatemehkp/projects/Zipcode PM NO2/data/processed';    
libname spt '/scratch/fatemehkp/projects/USA Spatial/data/processed';                                                  

/*
proc sort data=cms.enrollee65_ndi_0008_clean;
	by bene_id year month; 
run;
*/

/* beneficiries at time of enrollment */
* with pm data;
/*
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and ses_zip ne .;
run;

proc sort data=master0 nodupkey out=prcs.enrollee_pm_start;
	by bene_id; 
run;
	*/

* Add Region data;
proc sql;
	create table prcs.enrollee_pm_start as
	select *
	from prcs.enrollee_pm_start a
	left join spt.region_state b
	on a.state=b.state;
quit;

* with no2 data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and no2_1yr ne . and ses_zip ne .;
run;

proc sort data=master0 nodupkey out=prcs.enrollee_no2_start;
	by bene_id; 
run;

* with pm and brfss data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and ses_zip ne . and X_bmi_mean ne .;
run;
	
proc sort data=master0 nodupkey out=prcs.enrollee_pm_brfss_start;
	by bene_id; 
run;

* with no2 and brfss data;
data master0;
	set cms.enrollee65_ndi_0008_clean;
	where sex ne 'U' and pm_1yr ne . and no2_1yr ne . and ses_zip ne . and X_bmi_mean ne .;
run;
	
proc sort data=master0 nodupkey out=prcs.enrollee_no2_brfss_start;
	by bene_id; 
run;


* Add Region data;
proc sql;
	create table prcs.enrollee_no2_start as
	select *
	from prcs.enrollee_no2_start a
	left join spt.region_state b
	on a.state=b.state;
quit;






libname raw '/scratch/fatemehkp/projects/CMS/data/raw';
libname prcs '/scratch/fatemehkp/projects/CMS/data/processed';

*IMPORTANT;
* The death date is recorded in all month of the year of the death;

/*
proc sort data=raw.enrollee65_ndi_0008; 
	by bene_id bene_enrollmt_ref_yr month; 
run;
*/

* Remove the incorrect bene_death_dt following the first bene_death_dt;
data death_all; 
	set raw.enrollee65_ndi_0008(where=(bene_death_dt ne . and month(bene_death_dt)=month));
	by bene_id bene_enrollmt_ref_yr month;
		if first.bene_id = 1; 
run;

data death_all; 
	set death_all;
	rename bene_death_dt = bene_death_dt_1;
run;

proc sql;
	create table enrollee65_ndi as
	select *
	from raw.enrollee65_ndi_0008 a
	left join death_all b
		on a.bene_id=b.bene_id;
quit;

* Remove the rows after the first bene_death_dt;
data raw.enrollee65_ndi_0008_corrected; 
	set enrollee65_ndi;
	if bene_death_dt ne . then do;
		if bene_date > bene_death_dt_1 then delete;
	end;
	drop bene_death_dt_1;
run;

* create death dataset; 
data raw.enrollee65_dead_ndi_0008; 
	format year BEST12.; 
	set raw.enrollee65_ndi_0008_corrected;
	YEAR=BENE_ENROLLMT_REF_YR;
	if bene_death_dt ne . and month(bene_death_dt)=month then output;
	keep BENE_ID BENE_DEATH_DT BENE_SEX_IDENT_CD BENE_RACE_CD
		ZIP_CODE YEAR MONTH ENROLLEE_AGE ICD_CODE
		RECORD_COND_1 RECORD_COND_2 RECORD_COND_3 RECORD_COND_4
		RECORD_COND_5 RECORD_COND_6 RECORD_COND_7 RECORD_COND_8;
run;

* 15,863,059;
proc sql;
	title 'distinct death - death date';
	select count(distinct bene_id)
	from raw.enrollee65_dead_ndi_0008;
quit;

* create death dataset with ICD Code;
data raw.enrollee65_dead_ndi_0008_icd; 
	format year BEST12.; 
	set raw.enrollee65_ndi_0008_corrected;
	YEAR=BENE_ENROLLMT_REF_YR;
	if ICD_CODE ne '' then output;
	keep BENE_ID BENE_DEATH_DT BENE_SEX_IDENT_CD BENE_RACE_CD
		ZIP_CODE YEAR MONTH ENROLLEE_AGE ICD_CODE
		RECORD_COND_1 RECORD_COND_2 RECORD_COND_3 RECORD_COND_4
		RECORD_COND_5 RECORD_COND_6 RECORD_COND_7 RECORD_COND_8;
run;

* 15,716,449;
proc sql;
	title 'distinct death - icd';
	select count(distinct bene_id)
	from raw.enrollee65_dead_ndi_0008_icd;
quit;


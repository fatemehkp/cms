* Re-done 08-15-2022;
/* ICD code and Record Condiotion Code */

libname raw '/scratch/fatemehkp/projects/CMS/data/raw';


* create death dataset with ICD Code;
data raw.enrollee65_dead_ndi_0008_icd; 
	format year BEST12.; 
	set raw.enrollee65_ndi_0008;
	YEAR=BENE_ENROLLMT_REF_YR;
	if ICD_CODE ne '' then output;
	keep BENE_ID BENE_DEATH_DT NDI_DEATH_DT BENE_SEX_IDENT_CD BENE_RACE_CD
		ZIP_CODE YEAR MONTH ENROLLEE_AGE ICD_CODE
		RECORD_COND_1 RECORD_COND_2 RECORD_COND_3 RECORD_COND_4
		RECORD_COND_5 RECORD_COND_6 RECORD_COND_7 RECORD_COND_8;
run;

* create an ID for each beneficiary;
data raw.enrollee65_dead_ndi_0008_icd;
	set raw.enrollee65_dead_ndi_0008_icd;
	bene_code + 1;
run;

data cms;
	set raw.enrollee65_dead_ndi_0008_icd;
	keep ICD_CODE--bene_code;
run;

data cms;
	retain bene_code;
	set cms;
run;

proc export
	data = cms
	outfile='/scratch/fatemehkp/projects/CMS/data/raw/cms-icd-rc.csv'
	dbms=csv 
	replace;
run;

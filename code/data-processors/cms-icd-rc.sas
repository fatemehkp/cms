/* ICD code and Record Condiotion Code */

libname raw '/scratch/fatemehkp/projects/CMS/data/raw';


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



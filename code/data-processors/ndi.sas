* Re-done 08-19-2022;
* Convert ICD codes for cause-specific mortality to 1/0;
* Convert sex and race code to M/F and A/B/H/N/W/O;
* Add air pollution, urbanicity, ses, region and brfss data to CMS data;


libname raw '/scratch/fatemehkp/projects/CMS/data/raw';
libname prcs '/scratch/fatemehkp/projects/CMS/data/processed';
libname spt '/scratch/fatemehkp/projects/USA Spatial/data/processed';
libname air '/scratch/fatemehkp/projects/Zipcode PM NO2/data/processed';
libname air2 '/scratch/fatemehkp/projects/Zipcode Ozone PM/data/processed';

ods html close;
ods listing;

data prcs.enrollee65_ndi_0008_clean; 
	format year BEST12.; length sex $1 race $2; 
	set raw.enrollee65_ndi_0008;
	YEAR=BENE_ENROLLMT_REF_YR;

	if bene_sex_ident_cd = 1 then sex ='M';
		else if bene_sex_ident_cd = 2 then sex ='F';
			else sex='U';

	if bene_race_cd = 1 then race ='W';
		else if bene_race_cd = 2 then race ='B';
			else if bene_race_cd = 4 then race ='A';
				else if bene_race_cd = 5 then race ='H';
					else if bene_race_cd = 6 then race ='N';
						else race='O';

* ICD_CODE;
* All Cause & Accidental;
	if bene_death_dt ne . and month(bene_death_dt)=month then allcuz = 1;
		else allcuz = 0;

	if substr(ICD_CODE,1,1) in ('U','V','W','X','Y','Z') then acc = 1;
		else acc = 0;
		 
	nacc = allcuz - acc;
	
* CVD;
	if substr(ICD_CODE,1,1) in ('I') then cvd = 1;
		else cvd = 0;

	if substr(ICD_CODE,1,3) in ('I20','I21','I22','I23','I24','I25') then ihd = 1;
		else ihd = 0;

	if substr(ICD_CODE,1,3) in ('I50') then chf = 1;
		else chf = 0;

	if substr(ICD_CODE,1,2) in ('I6') then cbv = 1;
		else cbv = 0;

* Respiratory;
	if substr(ICD_CODE,1,1) in ('J') then resp = 1;
		else resp = 0;

	if substr(ICD_CODE,1,3) in ('J40','J41','J42','J43','J44') then copd = 1;
		else copd = 0;

	if substr(ICD_CODE,1,3) in ('J12','J13','J14','J15','J16','J17','J18') then pneu = 1;
		else pneu = 0;

	if substr(ICD_CODE,1,3) in ('J00','J01','J02','J03','J04','J05','J06') then uri = 1;
		else uri = 0;

	if substr(ICD_CODE,1,3) in ('J09','J10','J11','J12','J13','J14','J15','J16','J17','J18','J20','J21','J22') then lri = 1;
		else lri = 0;

	if substr(ICD_CODE,1,3) in ('J80') then ards = 1;
		else ards = 0;

* Cancer;
	if substr(ICD_CODE,1,1) in ('C','D') then canc = 1;
		else canc = 0;

	if substr(ICD_CODE,1,3) in ('C34') then lungc = 1;
		else lungc = 0;
	
* Sepsis;
	if substr(ICD_CODE,1,3) in ('A40','A41') then seps = 1;
		else seps = 0;

* Dementia;
	if substr(ICD_CODE,1,3) in ('F01') then VaD = 1;
		else VaD = 0;
		
	if substr(ICD_CODE,1,3) in ('F03') then UsD = 1;
		else UsD = 0;

	if substr(ICD_CODE,1,3) in ('F01', 'F02', 'F03') then demn = 1;
		else demn = 0;

* Nervous System;
	if substr(ICD_CODE,1,3) in ('G20') then PD = 1;
		else PD = 0;
	
	if substr(ICD_CODE,1,3) in ('G30') then AD = 1;
		else AD = 0;

	if substr(ICD_CODE,1,3) in ('G31') then NeD = 1;
		else NeD = 0;

	if substr(ICD_CODE,1,3) in ('G35') then MS = 1;
		else MS = 0;
	
* Diabetes;
	if substr(ICD_CODE,1,3) in ('E10') then diabt1 = 1;
		else diabt1 = 0;
	
	if substr(ICD_CODE,1,3) in ('E11') then diabt2 = 1;
		else diabt2 = 0;

* Kidney;
	if substr(ICD_CODE,1,3) in ('N18','N19') then kidn = 1;
		else kidn = 0;
		
* 1 - 4 Underlying Cause of Death;
* CVD;
	if substr(RECORD_COND_1,1,1) in ('I') or 
	   substr(RECORD_COND_2,1,1) in ('I') or 
	   substr(RECORD_COND_3,1,1) in ('I') or
	   substr(RECORD_COND_4,1,1) in ('I') then cvd_rc = 1;
	else cvd_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('I20','I21','I22','I23','I24','I25') or 
	   substr(RECORD_COND_2,1,3) in ('I20','I21','I22','I23','I24','I25') or 
	   substr(RECORD_COND_3,1,3) in ('I20','I21','I22','I23','I24','I25') or
	   substr(RECORD_COND_4,1,3) in ('I20','I21','I22','I23','I24','I25') then ihd_rc = 1;
	else ihd_rc = 0;
	
	if substr(RECORD_COND_1,1,3) in ('I50') or 
	   substr(RECORD_COND_2,1,3) in ('I50') or 
	   substr(RECORD_COND_3,1,3) in ('I50') or
	   substr(RECORD_COND_4,1,3) in ('I50') then chf_rc = 1;
	else chf_rc = 0;
	
	if substr(RECORD_COND_1,1,2) in ('I6') or 
	   substr(RECORD_COND_2,1,2) in ('I6') or 
	   substr(RECORD_COND_3,1,2) in ('I6') or
	   substr(RECORD_COND_4,1,2) in ('I6') then cbv_rc = 1;
	else cbv_rc = 0;

* Respiratory;
	if substr(RECORD_COND_1,1,1) in ('J') or 
	   substr(RECORD_COND_2,1,1) in ('J') or 
	   substr(RECORD_COND_3,1,1) in ('J') or
	   substr(RECORD_COND_4,1,1) in ('J') then resp_rc = 1;
	else resp_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('J40','J41','J42','J43','J44') or 
	   substr(RECORD_COND_2,1,3) in ('J40','J41','J42','J43','J44') or 
	   substr(RECORD_COND_3,1,3) in ('J40','J41','J42','J43','J44') or
	   substr(RECORD_COND_4,1,3) in ('J40','J41','J42','J43','J44') then copd_rc = 1;
	else copd_rc = 0;
	
	if substr(RECORD_COND_1,1,3) in ('J12','J13','J14','J15','J16','J17','J18') or 
	   substr(RECORD_COND_2,1,3) in ('J12','J13','J14','J15','J16','J17','J18') or 
	   substr(RECORD_COND_3,1,3) in ('J12','J13','J14','J15','J16','J17','J18') or
	   substr(RECORD_COND_4,1,3) in ('J12','J13','J14','J15','J16','J17','J18') then pneu_rc = 1;
	else pneu_rc = 0;
	

	if substr(RECORD_COND_1,1,3) in ('J00','J01','J02','J03','J04','J05','J06') or 
	   substr(RECORD_COND_2,1,3) in ('J00','J01','J02','J03','J04','J05','J06') or 
	   substr(RECORD_COND_3,1,3) in ('J00','J01','J02','J03','J04','J05','J06') or
	   substr(RECORD_COND_4,1,3) in ('J00','J01','J02','J03','J04','J05','J06') then uri_rc = 1;
	else uri_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('J09','J10','J11','J12','J13','J14','J15','J16','J17','J18','J20','J21','J22') or 
	   substr(RECORD_COND_2,1,3) in ('J09','J10','J11','J12','J13','J14','J15','J16','J17','J18','J20','J21','J22') or 
	   substr(RECORD_COND_3,1,3) in ('J09','J10','J11','J12','J13','J14','J15','J16','J17','J18','J20','J21','J22') or
	   substr(RECORD_COND_4,1,3) in ('J09','J10','J11','J12','J13','J14','J15','J16','J17','J18','J20','J21','J22') then lri_rc = 1;
	else lri_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('J80') or 
	   substr(RECORD_COND_2,1,3) in ('J80') or 
	   substr(RECORD_COND_3,1,3) in ('J80') or
	   substr(RECORD_COND_4,1,3) in ('J80') then ards_rc = 1;
	else ards_rc = 0;

* Sepsis;
	if substr(RECORD_COND_1,1,3) in ('A40','A41') or 
	   substr(RECORD_COND_2,1,3) in ('A40','A41') or 
	   substr(RECORD_COND_3,1,3) in ('A40','A41') or
	   substr(RECORD_COND_4,1,3) in ('A40','A41') then seps_rc = 1;
	else seps_rc = 0;

* Dementia;
	if substr(RECORD_COND_1,1,3) in ('F01') or 
	   substr(RECORD_COND_2,1,3) in ('F01') or 
	   substr(RECORD_COND_3,1,3) in ('F01') or
	   substr(RECORD_COND_4,1,3) in ('F01') then VaD_rc = 1;
	else VaD_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('F03') or 
	   substr(RECORD_COND_2,1,3) in ('F03') or 
	   substr(RECORD_COND_3,1,3) in ('F03') or
	   substr(RECORD_COND_4,1,3) in ('F03') then UsD_rc = 1;
	else UsD_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('F01', 'F02', 'F03') or 
	   substr(RECORD_COND_2,1,3) in ('F01', 'F02', 'F03') or 
	   substr(RECORD_COND_3,1,3) in ('F01', 'F02', 'F03') or
	   substr(RECORD_COND_4,1,3) in ('F01', 'F02', 'F03') then demn_rc = 1;
	else demn_rc = 0;

* Nervous System;
	if substr(RECORD_COND_1,1,3) in ('G20') or 
	   substr(RECORD_COND_2,1,3) in ('G20') or 
	   substr(RECORD_COND_3,1,3) in ('G20') or
	   substr(RECORD_COND_4,1,3) in ('G20') then PD_rc = 1;
	else PD_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('G30') or 
	   substr(RECORD_COND_2,1,3) in ('G30') or 
	   substr(RECORD_COND_3,1,3) in ('G30') or
	   substr(RECORD_COND_4,1,3) in ('G30') then AD_rc = 1;
	else AD_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('G31') or 
	   substr(RECORD_COND_2,1,3) in ('G31') or 
	   substr(RECORD_COND_3,1,3) in ('G31') or
	   substr(RECORD_COND_4,1,3) in ('G31') then NeD_rc = 1;
	else NeD_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('G35') or 
	   substr(RECORD_COND_2,1,3) in ('G35') or 
	   substr(RECORD_COND_3,1,3) in ('G35') or
	   substr(RECORD_COND_4,1,3) in ('G35') then MS_rc = 1;
	else MS_rc = 0;

* Diabete;
	if substr(RECORD_COND_1,1,3) in ('E10') or 
	   substr(RECORD_COND_2,1,3) in ('E10') or 
	   substr(RECORD_COND_3,1,3) in ('E10') or
	   substr(RECORD_COND_4,1,3) in ('E10') then diabt1_rc = 1;
	else diabt1_rc = 0;

	if substr(RECORD_COND_1,1,3) in ('E11') or 
	   substr(RECORD_COND_2,1,3) in ('E11') or 
	   substr(RECORD_COND_3,1,3) in ('E11') or
	   substr(RECORD_COND_4,1,3) in ('E11') then diabt2_rc = 1;
	else diabt2_rc = 0;

* Kidney;
	if substr(RECORD_COND_1,1,3) in ('N18','N19') or 
	   substr(RECORD_COND_2,1,3) in ('N18','N19') or 
	   substr(RECORD_COND_3,1,3) in ('N18','N19') or
	   substr(RECORD_COND_4,1,3) in ('N18','N19') then kidn_rc = 1;
	else kidn_rc = 0;

	keep BENE_ID ENROLLEE_AGE sex race 
		 ZIP_CODE YEAR MONTH
		 allcuz nacc acc cvd ihd chf cbv resp copd pneu uri lri ards
		 canc lungc seps VaD UsD demn PD AD NeD MS diabt1 diabt2 kidn
		 cvd_rc ihd_rc chf_rc cbv_rc resp_rc copd_rc pneu_rc uri_rc lri_rc ards_rc
		 seps_rc VaD_rc UsD_rc demn_rc PD_rc AD_rc NeD_rc MS_rc
		 diabt1_rc diabt2_rc kidn_rc;
run;


* Add SES data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a
	left join spt.ses_zipcd b
	on a.zip_code=b.zip_code and a.year=b.year;
quit;


* Add PM data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a 
	left join air.pm_zipcd b
	on a.zip_code=b.zip_code and a.year=b.year and a.month=b.month;
quit;


* Add NO2 data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a 
	left join air.no2_zipcd b
	on a.zip_code=b.zip_code and a.year=b.year and a.month=b.month;
quit;

* Add O3max8h data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a 
	left join air2.o3max8h_zipcd b
	on a.zip_code=b.zip_code and a.year=b.year;
quit;

* Add Urbanicity data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a
	left join spt.urbanicity_zipcd b
	on a.zip_code=b.zip_code;
quit;


* Add Urban SES category data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select a.*, b.ses_tertile
	from prcs.enrollee65_ndi_0008_clean a
	left join spt.ses_zipcd_urban_cat b
	on a.zip_code=b.zip_code and a.year=b.year;
quit;


* Add BRFSS data;
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a
	left join spt.brfss_zipcd b
	on a.zip_code=b.zip_code and a.year=b.year and a.month=b.month;
quit;

* Add Region data; 
proc sql;
	create table prcs.enrollee65_ndi_0008_clean as
	select *
	from prcs.enrollee65_ndi_0008_clean a
	left join spt.region_state b
	on a.state=b.state;
quit;


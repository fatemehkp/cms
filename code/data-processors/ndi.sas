* Convert ICD codes for cause-specific mortality to 1/0;
* Convert sex and race code to M/F and A/B/H/N/W/O;

libname raw '/scratch/fatemehkp/projects/CMS/data/raw';
libname prcs '/scratch/fatemehkp/projects/CMS/data/processed';

ods html close;
ods listing;

data enrollee_ndi; 
	format year BEST12.; 
	set raw.enrollee65_ndi_0008_corrected;
	YEAR=BENE_ENROLLMT_REF_YR;
	keep BENE_ID BENE_DEATH_DT BENE_SEX_IDENT_CD BENE_RACE_CD
		 ZIP_CODE YEAR MONTH ENROLLEE_AGE ICD_CODE
		 RECORD_COND_1 RECORD_COND_2 RECORD_COND_3 RECORD_COND_4
		 RECORD_COND_5 RECORD_COND_6 RECORD_COND_7 RECORD_COND_8;
run;

data prcs.enrollee65_ndi_0008_clean; 
	set enrollee_ndi;
*ICD_CODE;
* All Cause;
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
	
	if substr(ICD_CODE,1,3) in ('G30') then AD = 1;
		else AD = 0;

	if substr(ICD_CODE,1,3) in ('G31') then NeD = 1;
		else NeD = 0;
		
	if substr(ICD_CODE,1,3) in ('F03') then UsD = 1;
		else UsD = 0;
		
* Diabetes;
	if substr(ICD_CODE,1,3) in ('E10') then diabt1 = 1;
		else diabt1 = 0;
	
	if substr(ICD_CODE,1,3) in ('E11') then diabt2 = 1;
		else diabt2 = 0;

* Kidney;
	if substr(ICD_CODE,1,3) in ('N18','N19') then kidn = 1;
		else kidn = 0;
		
* 1 - 8 Underlying Cause of Death;
*CVD;
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

	if substr(RECORD_COND_1,1,3) in ('F03') or 
	   substr(RECORD_COND_2,1,3) in ('F03') or 
	   substr(RECORD_COND_3,1,3) in ('F03') or
	   substr(RECORD_COND_4,1,3) in ('F03') then UsD_rc = 1;
	else UsD_rc = 0;

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

	drop BENE_DEATH_DT ICD_CODE
		 RECORD_COND_1 RECORD_COND_2 RECORD_COND_3 RECORD_COND_4
		 RECORD_COND_5 RECORD_COND_6 RECORD_COND_7 RECORD_COND_8;
run;


data prcs.enrollee65_ndi_0008_clean; 
	length sex $1 race $2; 
	set prcs.enrollee65_ndi_0008_clean;
	if bene_sex_ident_cd = 1 then sex ='M';
		else if bene_sex_ident_cd = 2 then sex ='F';
			else sex='U';

	if bene_race_cd = 1 then race ='W';
		else if bene_race_cd = 2 then race ='B';
			else if bene_race_cd = 4 then race ='A';
				else if bene_race_cd = 5 then race ='H';
					else if bene_race_cd = 6 then race ='N';
						else race='O';
   
	drop bene_sex_ident_cd bene_race_cd ;
run;






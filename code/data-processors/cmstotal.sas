* Re-done 08-15-2022;

libname raw '/scratch/fatemehkp/projects/CMS/data/raw';


/*****************************/
* Total enrollee;
proc sql;
	title 'Total CMS enrollee 2000-2008';
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee65_ndi_0008;
quit;


/*****************************/
* Total zipcode;
proc sql;
	title 'Total zipcodes with CMS enrollee 2000-2008';
	select count(distinct zip_code) as num_zipcode
	from raw.enrollee65_ndi_0008;
quit;

/*****************************/
* Total Unidentified sex;
proc sql;
	title 'Total unidentified sex CMS enrollee 2000-2008';
	select count(distinct zip_code) as num_zipcode
	from raw.enrollee65_ndi_0008
	where bene_sex_ident_cd = 0;
quit;

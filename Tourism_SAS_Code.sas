data cr.cleaned_tourism;
	set cr.tourism (drop=_1995--_2013);
	length Country_Name $100 Tourism_Type $20;
	retain Country_Name "" Tourism_Type "";

	if A ne . then
		Country_Name=Country;

	if lowcase(country)="inbound tourism" then
		Tourism_Type="Inbound tourism";
	else if lowcase(Country)="outbound tourism" then
		Tourism_Type="Outbound tourism";

	if country_Name ne Country and Country ne Tourism_Type;
	series=upcase(series);

	if series=".." then
		Series="";
	ConversionType=scan(country, -1, " ");

	if _2014=".." then
		_2014=".";

	if ConversionType='Mn' then
		do;

			if _2014 ne "." then
				Y2014=input(_2014, 16.)*1000000;
			else
				Y2014=.;
			Category=cat(scan(country, 1, '-', 'r'), ' -US$');
		end;

	if ConversionType='Thousands' then
		do;

			if _2014 ne "." then
				Y2014=input(_2014, 16.)*1000;
			else
				Y2014=.;
			Category=scan(country, 1, '-', 'r');
		end;
	format y2014 comma25.;
	drop A ConversionType Country _2014;
run;

proc freq data=cr.Cleaned_tourism;
	tables category Tourism_Type Series;
run;

proc means data=cr.Cleaned_tourism min mean max n maxdec=0;
	var Y2014;
run;

proc print data=cr.cleaned_tourism;
run;

/* Create the custom format */
proc format;
	value contIDs 1="North America" 2="South America" 3="Europe" 4="Africa" 
		5="Asia" 6="Oceania" 7="Antarctica";
run;

/*Merge matching rows*/
proc sort data=cr.country_info (rename=(Country=Country_Name)) 
		out=country_sorted;
	by country_name;
run;

data final_tourism;
	merge cr.cleaned_tourism(in=t) country_Sorted(in=c);
	by country_name;

	if t=1 and c=1 then
		output Final_Tourism;
	format continent contIDs.;
run;

proc freq data=final_tourism nlevels;
table category series Tourism_Type Continent /nocum nopercent;
run;

proc means data=final_tourism min mean max maxdec=0;
var Y2014;
run;

/*create the nocountryfound table*/

data final_tourism
	NoCountryFound(keep=Country_Name);
	merge cr.cleaned_tourism(in=t) country_Sorted(in=c);
	by country_name;

	if t=1 and c=1 then output Final_Tourism;
	if (t=1 and c=0) and first.country_name=1 then output NoCountryFound;
	format continent contIDs.;
run;


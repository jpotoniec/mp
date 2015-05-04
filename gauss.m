1;

endk=10;

printf("\\begin{tabular}{l|");
for k = 0:endk
	printf("r");
endfor
printf("}\n");
for k = 0:0.01:0.09
	printf("& %1.2f", k);
endfor
printf("\\\\\n\\hline\n");

for x = [(0:0.1:1.7)]
	printf("%1.1f ", x);
	for y = (0:0.01:0.09)
		p=normcdf(x+y);
		printf(" & ");
		if(p>10^-3)
			printf("%1.3f", p);
		endif
	endfor
	printf("\\\\\n");
endfor
printf("\\end{tabular}\n");

1;

endk=10;

printf("\\begin{tabular}{l|");
for k = 0:endk
	printf("r");
endfor
printf("}\n");
printf("\\diagbox{$\\lambda$}{$k$}");
for k = 0:endk
	printf("& %d", k);
endfor
printf("\\\\\n\\hline\n");

for lambda = [(0.1:0.1:1.0),(2:7)]
	printf("%1.1f ", lambda);
	for k = 0:endk
		p=poisspdf(k,lambda);
		printf(" & ");
		if(p>10^-3)
			printf("%1.3f", p);
		endif
	endfor
	printf("\\\\\n");
endfor
printf("\\end{tabular}\n");

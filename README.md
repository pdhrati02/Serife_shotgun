This study was conducted on 28 male Wistar rats. There were four groups in this study. The MMKD+SCOP (n=8) group was fed a Mediterranean ketogenic diet (9 weeks) and scopolamine-induced cognitive impairment.   The KD+SCOP  (n=8) group was fed a classical ketogenic diet (9 weeks) and scopolamine-induced cognitive impairment. 
The SCOP group (n=6) was fed a standard diet and scopolamine-induced cognitive impairment. The CON group (n=6) was also fed a standard diet and was cognitively normal. 

Serife's shotgun data was processed using Kraken, as M4 was not working well for the rat data. See scripts for steps.

Finally I used kraken2 PlusPF db for taxonomic classification of your data. And then used bracken to get abundance results. Please find attached. 
 
You will see txt_num and txt_frac columns for each column. You can use txt_frac columns for all samples and make a file with that to use further – you will notice that the total for each of this frac (fraction) column is close to 1. As relative abundance should be around 1 when summed up.

I am also attaching humann3 results: pathway abundance data: this was done by joining all pathway abundance tables first, followed by renorm to cpm and then split stratify to make stratified and unstratified output file. Since humann3 uses metaphlan and chocophlan as the db there might be some results which might not be present in there because your data is wistar rats and not humans. Having said that it is still okay to use the results and I would say you can use the unstratified results first. 
 
I did the exact same with genefamily data and then I used regroup table to get ko’s assigned to this. I am sharing the unstratified output here for you. Stratified output will be too large, but if you do find something interesting with unstratified output we can peek into the stratified file later.


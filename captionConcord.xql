xquery version "3.1";

(::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 generates a caption concordance ordered by word frequency
 :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::)

declare namespace tei='http://www.tei-c.org/ns/1.0';

declare namespace cbml="http://www.cbml.org/ns/1.0";

<concordance>
{
let $caption := doc('/db/apps/teicomix/data/PL17_TEI.xml')//cbml:caption
for $tb in $caption/lower-case(.)
for $tbc in translate($tb, "!-,?.", "")
for $t in $tbc ! tokenize(., "\s")
let $occurrence := count($t)
group by $t
order by count($occurrence) descending

return
<caption w="{distinct-values($t)}" frequency="{count($occurrence)}">

</caption>
}
</concordance>

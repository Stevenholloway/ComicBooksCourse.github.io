xquery version "3.1";

(::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 generates a word frequency concordance organized alphabeticaly by word,
 with frequency and speaker
 :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::)

declare namespace tei='http://www.tei-c.org/ns/1.0';

declare namespace cbml="http://www.cbml.org/ns/1.0";

<concordance>
{
for $person in //tei:person
let $id := $person/@xml:id
let $idref := concat('#',$id)
let $speeches := doc('/db/apps/teicomix/data/PL17_TEI.xml')//cbml:balloon[@who=$idref]

for $tb in $speeches/lower-case(.)
for $tbc in translate($tb, "!-,?.()[]", "")
for $t in $tbc ! tokenize(., "\s")
let $occurrence := count($t)
group by $t order by $t
return
<word w="{distinct-values($t)}" frequency="{count($occurrence)}">
{
for $gwho in $id group by $gwho order by $gwho return
<character name="{$gwho}"/> }
</word>
}
</concordance>

xquery version "3.1";

(:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
generates a list of gender markers ordered by total hits, with character
names and discrete marker counts
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::)

declare namespace tei='http://www.tei-c.org/ns/1.0';

declare namespace cbml="http://www.cbml.org/ns/1.0";



<gender-markers>
{
let $document := doc('/db/apps/teicomix/data/PL17_TEI.xml')
for $person in $document//tei:person
let $id := $person/@xml:id
let $gender := $document//tei:note[@subtype=$id]/@ana
let $t := $gender ! tokenize(., "\s")
let $c := count($t)
group by $c order by $c descending
return


<character name="{$id}" total-hits="{count($t)}" distinct-markers="{count(distinct-values($t))}">
{distinct-values($t)}
</character>


}
</gender-markers>

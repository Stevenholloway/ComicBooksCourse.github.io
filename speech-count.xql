xquery version "3.1";

(::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
generates list of speakers, based on balloon entries, a count of their
speeches and breakdown by speech type, ordered by count
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::)

declare namespace tei='http://www.tei-c.org/ns/1.0';

declare namespace cbml="http://www.cbml.org/ns/1.0";


<results>{

let $speeches := doc('/db/apps/teicomix/data/PL17_TEI.xml')//cbml:balloon
let $speakers := $speeches/@who

let $distinctsp := distinct-values($speakers)
for $sp in $distinctsp
let $count := count($speeches[@who = $sp])
(:let $aural := count($speeches[@who=$sp and @type="speech"]) :)
let $dialogue := count($speeches[@who=$sp and @ana="#dialogue"])
let $monologue := count($speeches[@who=$sp and @ana="#monologue"])
let $interjection := count($speeches[@who=$sp and @ana="#interjection"])
let $command := count($speeches[@who=$sp and @ana="#command"])
let $thought := count($speeches[@who=$sp and @ana="#thought"])
let $narration := count($speeches[@who=$sp and @ana="#narration"])
order by $count descending
return

<speeches>
<speaker>{$sp}</speaker>
<count>{$count}</count>
<type-of-speech>
<dialogue>{$dialogue}</dialogue>
<monologue>{$monologue}</monologue>
<interjection>{$interjection}</interjection>
<thought>{$thought}</thought>
<command>{$command}</command>
<narration>{$narration}</narration>
</type-of-speech>
</speeches>

}</results>

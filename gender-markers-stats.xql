xquery version "3.1";

(:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 generates list of gender markers by binary sex, with total and unique hit
 count, and number of characters
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::)

declare namespace tei='http://www.tei-c.org/ns/1.0';

declare namespace cbml="http://www.cbml.org/ns/1.0";

let $document := doc('/db/apps/teicomix/data/PL17_TEI.xml')
let $sex1 := $document//tei:sex[@value="2"]
let $person1 := $sex1/ancestor::tei:person
let $id1 := $person1/@xml:id
let $gender1 := $document//tei:note[@subtype=$id1]/@ana
let $t1 := $gender1 ! tokenize(., "\s")

let $sex2 := $document//tei:sex[@value="1"]
let $person2 := $sex2/ancestor::tei:person
let $id2 := $person2/@xml:id
let $gender2 := $document//tei:note[@subtype=$id2]/@ana
let $t2 := $gender2 ! tokenize(., "\s")
return
  <gender-markers>

  <female total-count="{count($t1)}" number_of_characters="{count($id1)}" distinct-markers="{count(distinct-values($t1))}">
  {distinct-values($t1)}
  </female>
  <male total-count="{count($t2)}" number_of_characters="{count($id2)}" distinct-markers="{count(distinct-values($t2))}">
  {distinct-values($t2)}
  </male>

    </gender-markers>

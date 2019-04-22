xquery version "3.1";

(::::::::::::::::::::::::::::::::::::::::::::::::::::
generates list of panel descriptions with panel ##
::::::::::::::::::::::::::::::::::::::::::::::::::::)

declare namespace tei='http://www.tei-c.org/ns/1.0';

declare namespace cbml="http://www.cbml.org/ns/1.0";

<results>{

for $description in doc('/db/apps/teicomix/data/TEI_Rorschach.xml')//cbml:panel

return
<Description panel="{$description/@n}" author="{$description//tei:note/@resp}">
{data($description//tei:note[@type="panelDesc"])}
</Description>

}</results>

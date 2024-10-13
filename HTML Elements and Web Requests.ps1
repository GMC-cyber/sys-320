$scraped_page = Invoke-WebRequest -Timeoutsec 10 http://127.0.0.1/tobescraped.html

#$scraped_page.Links.Count 
#$scraped_page.Links
#$scraped_page.Links | Select-Object  "href" ,  "outerText"



#$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | ForEach-Object { $_.outerText }
#$h2s

$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where-object {
 $_.getAttributeNode("class").value -like "div-1" } | select innerText

$divs1

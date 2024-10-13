$ErrorActionPreference= 'silentlycontinue'

function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://127.0.0.1/Courses.html

    # Get all the tr elements of HTML document
    $trs = $page.ParsedHtml.getElementsByTagName("tr")

    # Empty array to hold results
    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++){
        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        # Want to separate start time and end time from one time field
        $Times = $tds[5].innerText.split("-")

        $FullTable += [PSCustomObject]@{
            "Class Code" = $tds[0].innerText
            "Title" = $tds[1].innerText
            "Days" = $tds[4].innerText
            "Time Start" = $Times[0].Trim()
            "Time End" = $Times[1].Trim()
            "Instructor" = $tds[6].innerText
            "Location" = $tds[9].innerText
        }
    }
    return $FullTable
}

function daysTranslator($FullTable){
    # Go over every record in the table
    for($i=0; $i -lt $FullTable.length; $i++){
        # Empty array to hold days for every record
        $Days = @()
        
        # If you see "M" -> Monday
        if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }
        
        # If you see "T" followed by T,W, or F -> Tuesday
        if($FullTable[$i].Days -ilike "*T[!H]*"){ $Days += "Tuesday" }
        
        # If you see "W" -> Wednesday
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }
        
        # If you see "TH" -> Thursday
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }
        
        # F -> Friday
        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }
        
        # Make the switch
        $FullTable[$i].Days = $Days
    }
    
    return $FullTable
}



$ErrorActionPreference= 'silentlycontinue'
. .\Untitled4.ps1


$FullTable = gatherClasses

$UpdatedTable = daysTranslator($FullTable)

 



 $UpdatedTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | Where-Object { $_."Instructor" -eq "Furkan Paligu"}

 $UpdatedTable | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.days -eq "Monday") } | Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code"


 $ITSInstructors = $FullTable | Where-Object {
    $_."Class Code" -match "SYS*" -or
    $_."Class Code" -match "NET*" -or
    $_."Class Code" -match "SEC*" -or
    $_."Class Code" -match "FOR*" -or
    $_."Class Code" -match "CSI*" -or
    $_."Class Code" -match "DAT*"
} | Select-Object -Property "Instructor" -Unique | Sort-Object "Instructor"

$ITSInstructors


$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } |
Group-Object "Instructor" |
Select-Object @{Name="Count";Expression={$_.Count}}, Name |
Sort-Object Count -Descending


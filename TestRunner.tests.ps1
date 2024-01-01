# Dot-source the Functional Library to import the nslookup function
. "D:\AutomationP6\Pester\FunctionLibrary\FunctionLibrary.ps1"

# Open the Excel Workbook
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$workbook = $excel.Workbooks.Open("D:\AutomationP6\Pester\InputSheet\API_Test_Suit_v0.1.xlsx")
$testssuitToRunSheet = $workbook.Worksheets.Item("TestControl")

Describe "Automated API Tests" {
  # AfterAll {
       # Close the Excel workbook
      # $workbook.Close($true)
     #  $excel.Quit()
      # [System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null
      # [System.GC]::Collect()
     #  [System.GC]::WaitForPendingFinalizers()
    # }

   $rowCount = $testssuitToRunSheet.UsedRange.Rows.Count
   for ($i = 2; $i -le $rowCount; $i++) {
       $component = $testssuitToRunSheet.Cells.Item($i, 1).Text
       $suitToRun = $testssuitToRunSheet.Cells.Item($i, 2).Text

       if ($suitToRun -eq "Y") {
           Context "Testing component: $component" {
               $componentSheet = $workbook.Worksheets.Item($component)
               $componentRowCount = $componentSheet.UsedRange.Rows.Count

               for ($j = 2; $j -le $componentRowCount; $j++) {
                   $functionKeyword = $componentSheet.Cells.Item($j, 6).Text
                   $testData = $componentSheet.Cells.Item($j, 7).Text

                   It "Executing $functionKeyword for $component with data $testData" {
                       $result = & $functionKeyword $testData
                       $result | Should Be "PASS"

 

 

                   }
               }
           }
       }
   }

   AfterAll {
   ConvertXmlToHtml
       # Close the Excel workbook
       $workbook.Close($true)
       $excel.Quit()
       [System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null
       [System.GC]::Collect()
       [System.GC]::WaitForPendingFinalizers()
   }
}

# Define the path for the Pester report
$reportPath = "D:\Program Files (x86)\MonitorPester\TestResults\PesterReport.xml"
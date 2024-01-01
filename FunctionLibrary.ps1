###############################################################################################
## Library Functions to test Rest APIs                                                       ##
## Methods GET, POST, PUT, DELETE, Authentication Token, Global Variables Setup              ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
## Version: 1.0 - Released for training & linkedin post                                      ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################


###############################################################################################
## Function Name: GenerateAuthToken                                                          ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################
function GenerateAuthToken {
    param(
        [string]$ApiTestData
    )

    # path for the output files
    $OutputBasePath = "D:\AutomationP6\Pester\Config"

    
        $ApiTestDataArray = $ApiTestData -split ","
    if ($ApiTestDataArray.Count -ge 3) {
        $Url = $ApiTestDataArray[0].Trim()
        $Method = $ApiTestDataArray[1].Trim()
        $ExpectedStatusCode = $ApiTestDataArray[2].Trim()
    } else {
        Write-Host "Invalid API test data format. Expected 'URL,Method,ExpectedStatusCode'. Received: $ApiTestData"
        return "FAIL"
    }

    # Validate URL and Method
    if (-not $Url -or -not $Method) {
        Write-Host "URL or Method is null or empty."
        return "FAIL"
    }

    # Create a unique filename for each API test result
    $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $OutputFileName = "ApiTest_Result_${Url}_${Method}_$Timestamp.txt"
    $OutputFilePath = Join-Path -Path $OutputBasePath -ChildPath $OutputFileName

    # Execute API call and capture the output
    $ErrorActionPreference = 'Continue'
    $ApiResponse = Invoke-RestMethod -Uri $Url -Method $Method *>&1
    $ApiResponse | Out-File -FilePath $OutputFilePath

    # Check if the API response status code matches the expected status code
    if ($ApiResponse.StatusCode -eq $ExpectedStatusCode) {
        return "PASS"
    } else {
        "API test failed with status code: $($ApiResponse.StatusCode)" | Out-File -FilePath $OutputFilePath -Append
        return "FAIL"
    }
}

###############################################################################################
## Function Name: VerifyApiGet                                                               ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################
function VerifyApiGet {
    param(
        [string]$ApiTestData
    )

    # base path for the output files
    $OutputBasePath = "D:\AutomationP6\Pester\TestResults\GET"

    # Read & Split input data array
    $ApiTestDataArray = $ApiTestData -split ","
    $Url = $ApiTestDataArray[0].Trim()
    $EmployeeId = $ApiTestDataArray[1].Trim()

    # Append if Id is provided
    if ($EmployeeId) {
        $Url += "/$EmployeeId"
    }

    # Create a unique file for each API test result
    $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $OutputFileName = "ApiTest_GetResult_${EmployeeId}_$Timestamp.txt"
    $OutputFilePath = Join-Path -Path $OutputBasePath -ChildPath $OutputFileName

    try {
        $ApiResponse = Invoke-RestMethod -Uri $Url -Method Get -Headers @{"Accept" = "application/json"}
        
        # Covnert the response to JSON & handle nested if any 
        $JsonResponse = $ApiResponse | ConvertTo-Json -Depth 10
        $JsonResponse | Out-File -FilePath $OutputFilePath

        if ($ApiResponse) {
            return "PASS"
        } else {
            return "FAIL"
        }
    } catch {
        Write-Host "Error occurred: $_"
        "Error: $_" | Out-File -FilePath $OutputFilePath -Append
        return "FAIL"
    }
}
###############################################################################################
## Function Name: VerifyApiPost                                                              ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################

function VerifyApiPost {
    param(
        [string]$ApiTestData,
        [hashtable]$Data
    )

    $OutputBasePath = "D:\AutomationP6\Pester\TestResults\POST"
    $Url = ($ApiTestData -split ",")[0].Trim()
    $JsonBody = $Data | ConvertTo-Json
    $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $OutputFileName = "ApiTest_PostResult_$Timestamp.txt"
    $OutputFilePath = Join-Path -Path $OutputBasePath -ChildPath $OutputFileName

    try {
        $ApiResponse = Invoke-RestMethod -Uri $Url -Method Post -ContentType "application/json" -Body $JsonBody
        $ApiResponse | Out-File -FilePath $OutputFilePath
        return "PASS"
    } catch {
        Write-Host "Error occurred: $_"
        "Error: $_" | Out-File -FilePath $OutputFilePath -Append
        return "FAIL"
    }
}

###############################################################################################
## Function Name: VerifyAPIPut                                                               ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################
function VerifyApiPut {
    param(
        [string]$ApiTestData,
        [hashtable]$Data
    )

    $OutputBasePath = "D:\AutomationP6\Pester\TestResults\PUT"
    $Url = ($ApiTestData -split ",")[0].Trim()
    $JsonBody = $Data | ConvertTo-Json
    $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $OutputFileName = "ApiTest_PutResult_$Timestamp.txt"
    $OutputFilePath = Join-Path -Path $OutputBasePath -ChildPath $OutputFileName

    try {
        $ApiResponse = Invoke-RestMethod -Uri $Url -Method Put -ContentType "application/json" -Body $JsonBody
        $ApiResponse | Out-File -FilePath $OutputFilePath
        return "PASS"
    } catch {
        Write-Host "Error occurred: $_"
        "Error: $_" | Out-File -FilePath $OutputFilePath -Append
        return "FAIL"
    }
}

###############################################################################################
## Function Name: VerifyAPIDelete                                                            ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################
    
function VerifyApiDelete {
    param(
        [string]$ApiTestData
    )

    $OutputBasePath = "D:\AutomationP6\Pester\TestResults\DELETE"
    $Url = ($ApiTestData -split ",")[0].Trim()
    $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $OutputFileName = "ApiTest_DeleteResult_$Timestamp.txt"
    $OutputFilePath = Join-Path -Path $OutputBasePath -ChildPath $OutputFileName

    try {
        $ApiResponse = Invoke-RestMethod -Uri $Url -Method Delete
        $ApiResponse | Out-File -FilePath $OutputFilePath
        return "PASS"
    } catch {
        Write-Host "Error occurred: $_"
        "Error: $_" | Out-File -FilePath $OutputFilePath -Append
        return "FAIL"
    }
}

###############################################################################################
## Function Name: ConvertXmlToHtml                                                           ##
##                                                                                           ##
## Author:  Naveen Sharma                                                                    ##
##                                                                                           ##
## History: N/A                                                                              ##
###############################################################################################
    
function ConvertXmlToHtml {
    $XmlPath = "D:\AutomationP6\Pester\NunitXML\RunReport.xml"
    $XsltPath = "D:\AutomationP6\Pester\Config\NunitTOHtml.xslt"
    $OutputHtmlPath = "D:\AutomationP6\Pester\TestReport\Test_Summary_Report.html"

    $xslt = New-Object System.Xml.Xsl.XslCompiledTransform
    try {
        $xslt.Load($XsltPath)
        $xslt.Transform($XmlPath, $OutputHtmlPath)
        Write-Host "XML to HTML conversion completed successfully."
    } catch {
        Write-Error "An error occurred during conversion: $_"
    }
}

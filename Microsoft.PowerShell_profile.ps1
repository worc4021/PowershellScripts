function MatlabBuilder
{
    param
    (
    [parameter(Mandatory=$true)]
    [String] $path
    )
    process
    {
        test-path $path
    }
}

function Exists-Var
{
    param
    (
    [parameter(Mandatory=$true)]
    [String] $Name
    )
    process
    {
        if (Get-Variable $Name -Scope Global -ErrorAction SilentlyContinue) { $true } else { $false }
    }
}

function Exists-Command
{
    param
    (
    [parameter(Mandatory=$true)]
    [String] $Name
    )
    process
    {
        if (Get-Command $Name -ErrorAction SilentlyContinue) {$true} else {$false}
    }
}


function Exists-Dir
{
    param
    (
    [parameter(Mandatory=$true)]
    [String] $Name
    )
    process
    {
        if (dir $Name -ErrorAction SilentlyContinue) {$true} else {$false}
    }
}


function Remote-Info
{
    param
    (
    [parameter(Mandatory=$true)]
    [String] $MachineName,
    [parameter(Mandatory=$false)]
    [String] $sn = "vdgcluster",
    [parameter(Mandatory=$false)]
    [String] $pw = "H0rs3P0w3r#"
    )
    process
    {
        iex "pslist \\$MachineName -u barf1\$sn -p $pw -t" -ErrorAction SilentlyContinue
    }
}

function MathematicaStript
{
    param
    (
    [parameter(Mandatory=$true)]
    [String] $scriptName
    )
    process
    {
        $outputFolder = ([System.IO.FileInfo]$scriptName).DirectoryName
        $outputName = ([System.IO.FileInfo]$scriptName).BaseName
        $outputFile = $outputFolder+"\"+$outputName+"_out.m"
        
        Start-Process -FilePath "C:\Program Files (x86)\Wolfram Research\MathLM\mathlm.exe" -WindowStyle Hidden
        MathKernel -script $scriptName 1> $outputFile
        Stop-Process -Name mathlm
    }
}


New-Alias -Name python -Value 'C:\Program Files\WinPython-64bit-2.7.10.3\python-2.7.10.amd64\python.exe'
New-Alias -Name MathKernel -Value 'C:\Program Files\Wolfram Research\Mathematica\10.3\math.exe'
New-Alias -Name git -Value 'C:\ProgramData\Git\bin\git.exe'
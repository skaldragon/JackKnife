Add-Type -AssemblyName presentationframework, presentationcore
$wpf = @{ }
$inputXML = Get-Content -Path "C:\Users\$env:USERNAME\source\repos\JackKnife\JackKnife\MainWindow.xaml"
$inputXMLClean = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace 'x:Class=".*?"','' -replace 'd:DesignHeight="\d*?"','' -replace 'd:DesignWidth="\d*?"',''
[xml]$xaml = $inputXMLClean
$reader = New-Object System.Xml.XmlNodeReader $xaml
$tempform = [Windows.Markup.XamlReader]::Load($reader)
$namedNodes = $xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")
$namedNodes | ForEach-Object {$wpf.Add($_.Name, $tempform.FindName($_.Name))}
$wpf.Add_Stream.add_checked({})
$wpf.Remove_Stream.add_checked({})
$wpf.Unique_Stream.add_checked({})
$wpf.View_Stream.add_checked({})

$wpf.Get_Stream_Button.add_click({

if($wpf.Add_Stream.IsChecked -and !$wpf.Remove_Stream.IsChecked -and !$wpf.View_Stream.IsChecked -and !$wpf.Unique_Stream.IsChecked){
$Filepath=$wpf.FilePathText.Text
$StreamName=$wpf.AddStream_Text.Text
$Content=$wpf.Contentbox.Text
Add-Content -Stream $StreamName -Value $Content -Path $Filepath 

$AddForm=New-Object System.Windows.Forms.Form
$AddForm.ClientSize='200,200' 
$AddBox=New-Object System.Windows.Forms.Label
$AddBox.Text="Added Stream"
$AddBox.Width=55
$AddBox.Height=50
$AddBox.Location='25,25'

$AddCancel=New-Object System.Windows.Forms.Button
$AddCancel.Text="OK"
$AddCancel.Location='40,100'
$AddCancel.Height=30
$AddCancel.Width=30
$AddForm.CancelButton=$AddCancel
$AddForm.controls.AddRange(@($AddBox,$AddCancel))
$AddForm.ShowDialog()


}
if($wpf.View_Stream.IsChecked -and !$wpf.Add_Stream.IsChecked -and !$wpf.Remove_Stream.IsChecked -and !$wpf.Unique_Stream.IsChecked){
$Filepath=$wpf.FilePathText.Text
$StreamName=$wpf.ViewStreamText.Text
Get-Content -Stream $StreamName -Path $Filepath | Out-GridView
}

if($wpf.Remove_Stream.IsChecked -and !$wpf.Add_Stream.IsChecked -and !$wpf.View_Stream.IsChecked -and !$wpf.Unique_Stream.IsChecked){
$Filepath=$wpf.FilePathText.Text
$StreamName=$wpf.RemoveStreamText.Text
Remove-Item -Path $FilePath -Stream $StreamName

$Removeform=New-Object System.Windows.Forms.Form
$Removeform.ClientSize='200,200' 
$Removebox=New-Object System.Windows.Forms.Label
$Removebox.Text="Remove Complete"
$Removebox.Width=55
$Removebox.Height=50
$Removebox.Location='25,25'

$RemoveCancel=New-Object System.Windows.Forms.Button
$RemoveCancel.Text="OK"
$RemoveCancel.Location='40,100'
$RemoveCancel.Height=30
$RemoveCancel.Width=30
$Removeform.CancelButton=$RemoveCancel
$Removeform.controls.AddRange(@($Removebox,$RemoveCancel))
$Removeform.ShowDialog()

}
if(!$wpf.Add_Stream.IsChecked -and !$wpf.Remove_Stream.IsChecked -and !$wpf.View_Stream.IsChecked -and !$wpf.Unique_Stream.IsChecked -and $wpf.FilePathText.Text -ne "$null"){
$Filepath=$wpf.FilePathText.Text
Get-ChildItem -Path $Filepath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Select Filename,Stream | Out-GridView
}
if($wpf.Unique_Stream.IsChecked -and !$wpf.Add_Stream.IsChecked -and !$wpf.View_Stream.IsChecked -and !$wpf.Remove_Stream.IsChecked){
$Filepath=$wpf.FilePathText.Text
$var=(Get-ChildItem -Path $FilePath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA' -and $_.Stream -ne "Zone.Identifier"}).Stream;
$var2=(Get-ChildItem -Path $FilePath -Recurse *.* | ForEach-Object { Get-Item -Path $_.FullName | Get-Item -Stream * } | Where-Object { $_.Stream -ne ':$DATA' -and $_.Stream -ne "Zone.Identifier"}).FileName;
write-host "These are your Unique Stream names:"| Out-GridView; 
"$var2, $var" | Out-GridView; 
}
elseif(!$wpf.Add_Stream.IsChecked -and !$wpf.Remove_Stream.Unchecked -and !$wpf.View_Stream.Unchecked -and !$wpf.Unique_Stream.IsChecked -and $wpf.FilePathText.Text -eq "$null"){
$errorform=New-Object System.Windows.Forms.Form
$errorform.ClientSize='200,200' 
$errorBox=New-Object System.Windows.Forms.Label
$errorbox.Text="Error"
$errorbox.Width=30
$errorbox.Height=20
$errorBox.Location='25,25'

$errorcancel=New-Object System.Windows.Forms.Button
$errorcancel.Text="OK"
$errorcancel.Location='40,100'
$errorcancel.Height=30
$errorcancel.Width=30
$errorform.CancelButton=$errorcancel
$errorform.controls.AddRange(@($errorbox,$errorcancel))
$errorform.ShowDialog()
}
})
$wpf.Get_Stream.ShowDialog()

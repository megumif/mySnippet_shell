# Olympus image用　
# オリンパスの顕微鏡は、画像フォルダ('hogehoge.vsi')に付随して画像フォルダとファイル('_hogehoge/stck01/...')がついてくる。
# この親フォルダの更新時刻が曲者で親フォルダを移動・コピーしていると変わってしまう。そこで親フォルダの更新時刻を画像フォルダのものと同一にする
$folderList=Get-ChildItem -Directory

foreach($subjFolders in $folderList) {
Get-ChildItem -File $subjFolders | Foreach-Object {
    $infile = Join-Path $subjFolders $_.name
    
    write-host "Source folder"
    echo $infile
    
    if((Get-Childitem $infile).Extension -match '.vsi'){
    #if($infile.Substring($infile.Length-3, 3) -match 'vsi'){
    $fileBase=[io.path]::GetFileNameWithoutExtension($_)
    $filter_fileBase='_'+$fileBase+'_'
    $infile_relatedFolders = Get-ChildItem -Path $subjFolders -Filter $filter_fileBase
    
    write-host "relatedFolder"
    echo $infile_relatedFolders
    
    }else{
    }
    $dir_dest = Join-Path $subjFolders $(Get-ItemProperty $(Join-Path  $subjFolders $_)).LastWriteTime.ToString("yyyyMMdd")
    ### alternatively - 
    #$dir_dest = Join-Path $subjFolders $(Get-ItemProperty $(Join-Path  $subjFolders $_)).CreationTime.ToString("yyyyMMdd")
    
    # test if destination exists
    $result = (Test-Path $dir_dest)
        if($result){
    }else{
    mkdir $dir_dest
    } 
    
    Move-Item $infile -Destination $dir_dest
    if ($infile_relatedFolders -eq $null){
    }else{
    Move-Item (Join-Path $subjFolders $infile_relatedFolders) -Destination $dir_dest
    }
}
}

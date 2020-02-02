# organize files with date folder

# get datelist
$fileList=Get-ChildItem -File
$dateList= ($fileList | ForEach-Object { (Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd") })
Get-ChildItem | Where-Object { $_ -is [System.IO.FileInfo] } | ForEach-Object { (Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd") }

# ユニークな要素を取り出し、フォルダの中に日付フォルダを作る
mkdir $(Get-ChildItem | Where-Object { $_ -is [System.IO.FileInfo] } | ForEach-Object { (Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd") } | Get-Unique)


# 更新日時によってファイルをよりわける
Get-ChildItem $indir | Foreach-Object {
    echo $infile
    $infile = $_.name
    $infile_relatedFolders = $_.name
    echo $infile_relatedFolders
    $dir_dest = $(Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd")
    # test if destination exists
    $result = (Test-Path $dir_dest)
    if($result){
    
    }else{
    mkdir $dir_dest
    
    } 
    Move-Item $infile -Destination $dir_dest
}

# Olympus image用　
# オリンパスの顕微鏡は、画像フォルダ('hogehoge.vsi')に付随して画像フォルダとファイル('_hogehoge/stck01/...')がついてくる。
# この親フォルダの更新時刻が曲者で親フォルダを移動・コピーしていると変わってしまう。そこで親フォルダの更新時刻を画像フォルダのものと同一にする
$folderList=Get-ChildItem -Directory

foreach($subjFolders in $folderList) {
Get-ChildItem -File $subjFolders | Foreach-Object {
    $infile = Join-Path $subjFolders $_.name
    echo $infile
    if($infile.Substring($infile.Length-3, 3) -match 'vsi'){
    $infile_relatedFolders = '_'+$_.name.Substring(0, $_.name.Length-4)+'_'
    }else{
    }
    $dir_dest = Join-Path $subjFolders.name $(Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd")
    echo $dir_dest
    # test if destination exists
    $result = (Test-Path $dir_dest)
        if($result){
    }else{
    mkdir $dir_dest
    } 
    Move-Item $infile -Destination $dir_dest
    if ($infile_relatedFolders -eq $null){
    }else{
    Move-Item $infile_relatedFolders -Destination $dir_dest
    }
}
}

foreach($subjFolders in $folderList) {
Get-ChildItem -File $subjFolders | Foreach-Object {
    $infile = $subjFolders.name
    
    if($infile.Substring($infile.Length-3, 3) -match 'vsi'){
    $infile_relatedFolders = '_'+$subjFolders.name.Substring(0, $subjFolders.name.Length-4)+'_'
    }else{
    }
    $dir_dest = $(Get-ItemProperty $subjFolders).LastWriteTime.ToString("yyyyMMdd")
    echo $dir_dest
    # test if destination exists
    $result = (Test-Path $dir_dest)
        if($result){
    }else{
    mkdir $dir_dest
    } 
    Move-Item $infile -Destination $dir_dest
    if ($infile_relatedFolders -eq $null){
    }else{
    Move-Item $infile_relatedFolders -Destination $dir_dest
    }
}
}


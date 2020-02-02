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

Get-ChildItem -File $indir | Foreach-Object {
    $infile = $_.name
    
    if($infile.Substring($infile.Length-3, 3) -match 'vsi'){
    $infile_relatedFolders = '_'+$_.name.Substring(0, $_.name.Length-4)+'_'
    }else{
    }
    $dir_dest = $(Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd")
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

Get-ChildItem -File $indir | Foreach-Object {
    $infile = $_.name
    
    if($infile.Substring($infile.Length-3, 3) -match 'vsi'){
    $infile_relatedFolders = '_'+$_.name.Substring(0, $_.name.Length-4)+'_'
    echo $infile_relatedFolders
    }else{
    }
    
    $dir_dest = $(Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd")
    
}

# Olympus image用　
# オリンパスの顕微鏡は、画像フォルダ('hogehoge.vsi')に付随して画像フォルダとファイル('_hogehoge/stck01/...')がついてくる。
# この親フォルダの更新時刻が曲者で親フォルダを移動・コピーしていると変わってしまう。そこで親フォルダの更新時刻を画像フォルダのものと同一にする
$olyviaFolders=Get-ChildItem -Name ./'_*'

$olyviaFolders | Foreach-Object {Get-ItemProperty ($_.Substring(1, $_.Length-2)).LastWriteTime.ToString("yyyyMMdd")}

Get-ChildItem $olyviaFolders | Foreach-Object {
　　$(Get-ItemProperty $_.Substring(1, $_.Length-2)).LastWriteTime.ToString("yyyyMMdd")
     }



Set-ItemProperty $FILENAME -Name LastWriteTime -Value "YYYY/MM/DD hh:mm:ss"

Get-ChildItem $indir | Foreach-Object {
    echo $infile
    $infile = $_.name
    $dir_dest = $(Get-ItemProperty $_).LastWriteTime.ToString("yyyyMMdd")
    # test if destination exists
    $result = (Test-Path $dir_dest)
    if($result){
    
    }else{
    mkdir $dir_dest
    
    } 
    Move-Item $infile -Destination $dir_dest
}





# d:\temp\test.txt が存在するかを確認
$result = (Test-Path "d:\temp\test.txt")
 
if($result){
    #ファイルが存在する場合はこちらが実行されます。
    Write-Host "ファイルは存在します。"
}else{
    #ファイルが存在しない場合はこちらが実行されます。
    Write-Host "ファイルは存在しません。"
} 

# organize files with date folder
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


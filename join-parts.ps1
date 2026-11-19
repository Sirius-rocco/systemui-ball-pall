# 把下载的分卷拼回 APK（Windows PowerShell）
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$out = Join-Path $dir 'SystemUI-ball-pall-domestic-full-aall-debug.apk'
if (Test-Path $out) { Remove-Item $out }
Get-ChildItem -Path $dir -Filter '*.part*' | Sort-Object Name | ForEach-Object {
  $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
  $fs = [System.IO.File]::Open($out, 'Append')
  $fs.Write($bytes, 0, $bytes.Length); $fs.Close()
}
$h = (Get-FileHash $out -Algorithm SHA256).Hash.ToLower()
Write-Host "拼回完成: $out"
Write-Host "SHA256: $h"
if ($h -eq '967811d11f52f201b71a895bd7ab6b1306917988f14720859ee9478a2528665a') { Write-Host '校验一致 ✅' } else { Write-Host '校验不一致 ❌ 请重新下载' }

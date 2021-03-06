# http://unattended.sourceforge.net/installers.php

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";
$client = New-Object System.Net.WebClient;
Add-Type -AssemblyName System.IO.Compression.FileSystem;

Write-Host "Creating Folders:";
$temp = "$Env:TEMP\CoderDojo";
if (-not (Test-Path $temp)) {
	Write-Host "  Temp";
	mkdir $temp;
}

$root = Resolve-Path "$PSScriptRoot\..";
$programs = "$root\Programs";
if (-not (Test-Path $programs)) {
	Write-Host "  Programs";
	mkdir $programs;
}

$documents = "$root\Documents";
if (-not (Test-Path $documents)) {
	Write-Host "  Documents";
	mkdir $documents;
}

Write-Host "Copying files to root:";
if (-not (Test-Path "$root\Autorun.inf")) {
	Write-Host "  Autorun";
	Copy-Item "$PSScriptRoot\Autorun.inf" -Destination $root
}
if (-not (Test-Path "$root\config.psd1")) {
	Write-Host "  Config";
	Copy-Item "$PSScriptRoot\config.psd1" -Destination $root
}

Write-Host "Installing Applications";

Write-Host "VS Code (Development Environment)";
if (-not (Test-Path "$programs\VSCode")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("http://go.microsoft.com/fwlink/?Linkid=850641", "$temp\VSCode.zip");
	Write-Host "  Installing...";
	[System.IO.Compression.ZipFile]::ExtractToDirectory("$temp\VSCode.zip", "$programs\VSCode");
	Write-Host "  Done.";
}

Write-Host "Git (Version Control)";
if (-not (Test-Path "$programs\Git")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/git-for-windows/git/releases/download/v2.21.0.windows.1/PortableGit-2.21.0-64-bit.7z.exe", "$programs\PortableGit.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$programs\PortableGit.exe -y";
	Rename-Item "$programs\PortableGit" "Git"
	Remove-Item "$programs\PortableGit.exe";
	Write-Host "  Done.";
}

Write-Host "PuTTY (Remote Host Access)";
if (-not (Test-Path "$programs\PuTTY")) {
	mkdir "$programs\PuTTY";
	Write-Host "  Downloading...";
	$client.DownloadFile("https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe", "$programs\PuTTY\putty.exe");
	$client.DownloadFile("https://the.earth.li/~sgtatham/putty/latest/w64/puttygen.exe", "$programs\PuTTY\puttygen.exe");
	Write-Host "  Done.";
}

Write-Host "NodeJS (JavaScript Language)";
if (-not (Test-Path "$programs\Node")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://nodejs.org/dist/v12.2.0/node-v12.2.0-win-x64.zip", "$temp\node.zip");
	Write-Host "  Installing...";
	[System.IO.Compression.ZipFile]::ExtractToDirectory("$temp\node.zip", "$programs");
	Rename-Item "$programs\node-v12.2.0-win-x64" "Node"
	Write-Host "  Done.";
}

Write-Host "mongoDB (NoSQL Database)";
if (-not (Test-Path "$programs\mongoDB")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-4.0.9.zip", "$temp\mongodb.zip");
	Write-Host "  Installing...";
	[System.IO.Compression.ZipFile]::ExtractToDirectory("$temp\mongodb.zip", "$programs");
	Rename-Item "$programs\mongodb-win32-x86_64-2008plus-ssl-4.0.9" "mongoDB"
	Write-Host "  Done.";
}

Write-Host "MariaDB (SQL Database)";
if (-not (Test-Path "$programs\MariaDB")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("http://mirror.takeshi.nz/mariadb//mariadb-10.3.15/winx64-packages/mariadb-10.3.15-winx64.zip", "$temp\mariadb.zip");
	Write-Host "  Installing...";
	[System.IO.Compression.ZipFile]::ExtractToDirectory("$temp\mariadb.zip", "$programs");
	Rename-Item "$programs\mariadb-10.3.15-winx64" "MariaDB"
	Write-Host "  Done.";
}

Write-Host "Caddy (Web Server)";
if (-not (Test-Path "$programs\Caddy")) {
	mkdir "$programs\Caddy";
	Write-Host "  Downloading...";
	$client.DownloadFile("https://caddyserver.com/download/windows/amd64?plugins=http.cache,http.cors,http.expires,http.login,http.minify,http.realip&license=personal&telemetry=off", "$programs\Caddy\caddy.exe");
	Write-Host "  Done.";
}

Write-Host "Arduino (Development Environment)";
if (-not (Test-Path "$programs\Arduino")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://downloads.arduino.cc/arduino-1.8.9-windows.zip", "$temp\arduino.zip");
	Write-Host "  Installing...";
	[System.IO.Compression.ZipFile]::ExtractToDirectory("$temp\arduino.zip", "$programs");
	Rename-Item "$programs\arduino-1.8.9" "Arduino"
	mkdir "$programs\Arduino\portable";
	Write-Host "  Done.";
}

Write-Host "Espruino (Development Environment)";
if (-not (Test-Path "$programs\Espruino")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("http://www.espruino.com/files/espruino_ide_win64_0v70.6.exe", "$temp\espruino_ide.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\espruino_ide.exe /S /D=""$programs\Espruino""";
	Write-Host "  Done.";
}

Write-Host "WinPython (Python Language)";
if (-not (Test-Path "$programs\Python")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/winpython/winpython/releases/download/1.11.20190223/Winpython64-3.7.2.0Zero.exe", "$temp\Winpython.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\Winpython.exe /VERYSILENT /NORESTART /CLOSEAPPLICATIONS /NOICONS /DIR=""$programs\Python""";
	Write-Host "  Done.";
}

Write-Host "Firefox (Developer Browser)";
if (-not (Test-Path "$programs\Firefox")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/portapps/firefox-developer-portable/releases/download/67.0b18-9/firefox-developer-portable-win64-67.0b18-9-setup.exe", "$temp\firefox-developer-portable.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\firefox-developer-portable.exe /VERYSILENT /NORESTART /CLOSEAPPLICATIONS /NOICONS /DIR=""$programs\Firefox""";
	Write-Host "  Done.";
}

Write-Host "Postman (API Testing)";
if (-not (Test-Path "$programs\Postman")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/portapps/postman-portable/releases/download/7.1.1-10/postman-portable-win64-7.1.1-10-setup.exe", "$temp\postman-portable.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\postman-portable.exe /VERYSILENT /NORESTART /CLOSEAPPLICATIONS /NOICONS /DIR=""$programs\Postman""";
	Write-Host "  Done.";
}

Write-Host ".NET Core (C# Language)";
if (-not (Test-Path "$programs\DotNet")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://dot.net/v1/dotnet-install.ps1", "$temp\dotnet-install.ps1");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\dotnet-install.ps1 -NoPath -InstallDir $programs\DotNet";
	Write-Host "  Done.";
}

Write-Host "KiTTY (Remote Host Access)";
if (-not (Test-Path "$programs\Kitty")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/portapps/kitty-portable/releases/download/0.70.0.10-1/kitty-portable-win32-0.70.0.10-1-setup.exe", "$temp\kitty-portable.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\kitty-portable.exe /VERYSILENT /NORESTART /CLOSEAPPLICATIONS /NOICONS /DIR=""$programs\Kitty""";
	Write-Host "  Done.";
}

Write-Host "Docker (Virtualisation)";
if (-not (Test-Path "$programs\Docker")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/portapps/docker-toolbox-portable/releases/download/18.09.3-5/docker-toolbox-portable-win64-18.09.3-5-setup.exe", "$temp\docker-toolbox-portable.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\docker-toolbox-portable.exe /VERYSILENT /NORESTART /CLOSEAPPLICATIONS /NOICONS /DIR=""$programs\Docker""";
	Write-Host "  Done.";
}

Write-Host "Discord (Instant Messaging)";
if (-not (Test-Path "$programs\Discord")) {
	Write-Host "  Downloading...";
	$client.DownloadFile("https://github.com/portapps/discord-portable/releases/download/0.0.305-1/discord-portable-win32-0.0.305-1-setup.exe", "$temp\discord-portable.exe");
	Write-Host "  Installing...";
	Invoke-Expression "$temp\discord-portable.exe /VERYSILENT /NORESTART /CLOSEAPPLICATIONS /NOICONS /DIR=""$programs\Discord""";
	Write-Host "  Done.";
}

Write-Host "Deleting Temp Folder";
#Remove-Item –path $temp –recurse;

function shortcut($source, $destination, $arguments) {
	$WshShell = New-Object -comObject WScript.Shell;
	$Shortcut = $WshShell.CreateShortcut($destination);
	$Shortcut.TargetPath = $source;
	$Shortcut.Arguments = $arguments;
	$Shortcut.Save();
}
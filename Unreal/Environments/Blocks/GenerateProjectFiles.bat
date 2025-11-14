setlocal
del /q gen_temp.txt
echo %UE4_ROOT%\Engine\Binaries\Win64\UnrealVersionSelector.exe > gen_temp.tmp
:: powershell -command "& { (Get-ItemProperty 'Registry::HKEY_CLASSES_ROOT\Unreal.ProjectFile\shell\rungenproj' -Name 'Icon' ).'Icon' } > gen_temp.tmp"
type gen_temp.tmp > gen_temp.txt
set /p gen_bin=<gen_temp.txt
del /q gen_temp.tmp
del /q gen_temp.txt
for %%f in (*.uproject) do (
		echo Generating files for %%f
		:: 代替了：%gen_bin% /projectfiles "%cd%\%%f"
		:: 以防止弹出 Unreal Engine 版本选择窗口以组织自动编译
		"%UE4_ROOT%\Engine\Build\BatchFiles\Build.bat" -projectfiles -project="%cd%\%%f" -game -progress
)

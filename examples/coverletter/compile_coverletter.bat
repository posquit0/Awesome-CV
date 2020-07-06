@echo off
rem compile coverletter.tex to produce coverletter.pdf and
rem remove temporary files generated during compilation
rem usage: double click or type the below in the command prompt
rem        compile_coverletter.bat
rem author: Ravi Joshi
rem date: 06 july 2020
rem note: this file is designed for Windows based OS
rem -------------------------------------------------

set dir=%cd%

rem define the main file
set file_name=coverletter

rem declare all temporary files
set temp_file_extensions=aux bcf log out run.xml

rem delete the existing file
if exist %file_name%.pdf (
  echo Removing existing %file_name%.pdf. Please wait...
  del /f /q %file_name%.pdf
)

echo Running xelatex. Please wait...
xelatex %file_name%.tex

echo Removing temporary files. Please wait...
for %%a in (%temp_file_extensions%) do (
  if exist "%dir%\*.%%a" (
    del /f /q /s "%dir%\*.%%a"
  )
)

echo Finished. Generated file is %file_name%.pdf

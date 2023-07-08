@echo off

echo Welcome to the GZDoom Networker!

echo:
echo:

set GZDOOM_LOCATION=%LOCALAPPDATA%\Programs\gzdoom\gzdoom.exe
echo Game Location: %GZDOOM_LOCATION%

echo:
echo:

echo Would you like to join or host? (join/host) 
set /p HOST_OR_JOIN=

echo:
echo:

IF %HOST_OR_JOIN%==host (
    GOTO :host
  )

echo The GZDoom Networker is now in Joining Mode.

echo:
echo:

echo Please enter target IP Address:

set /p TARGET_IP_ADDRESS=

%GZDOOM_LOCATION% -join %TARGET_IP_ADDRESS%

pause
exit

:host

echo The GZDoom Networker is now in Hosting Mode.

echo:
echo:

set HOST_COMMAND=%GZDOOM_LOCATION% -host

echo:
echo:

echo Which level would you like to use? 
set /p GAME_LEVEL=

set HOST_COMMAND=%HOST_COMMAND% -skill %GAME_LEVEL%

echo:
echo:

echo Is this a deathmatch? (y/n) 
set /p DEATHMATCH=

echo:
echo:

IF %DEATHMATCH%==y (
  set HOST_COMMAND=%HOST_COMMAND% -deathmatch
) ELSE (
  echo Which difficulty would you like to use? 
  set /p DIFFICULTY=

  set HOST_COMMAND=%HOST_COMMAND% -skill %DIFFICULTY%
)

echo:
echo:

FOR /f "tokens=1* delims=: " %%A IN (
  'nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) DO set ExtIP=%%B
echo External IP is: %ExtIP%

echo:
echo:

%HOST_COMMAND%

pause
exit

@echo off
setlocal enabledelayedexpansion

REM Get the root directory (parent of bin directory)
set "ROOT_DIR=%~dp0.."
REM Convert to absolute path and normalize
for %%I in ("%ROOT_DIR%") do set "ROOT_DIR=%%~fI"

REM Get caller directory (current working directory)
set "CALLER_DIR=%cd%"

REM Change to root directory
cd /d "%ROOT_DIR%"

REM Set environment variable for caller directory
set "CALLER_DIR=%CALLER_DIR%"

REM Check if recovery CLI is forced
if "%CLAUDE_CODE_FORCE_RECOVERY_CLI%" == "1" (
  bun --env-file=.env ./src/localRecoveryCli.ts %*
) else (
  bun --env-file=.env ./src/entrypoints/cli.tsx %*
)

endlocal
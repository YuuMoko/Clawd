#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

# Get the root directory (parent of bin directory)
$ROOT_DIR = Join-Path $PSScriptRoot ".." | Resolve-Path
# Get caller directory (current working directory)
$CALLER_DIR = Get-Location

# Change to root directory
Set-Location $ROOT_DIR

# Set environment variable for caller directory
$env:CALLER_DIR = $CALLER_DIR.Path

# Check if recovery CLI is forced
if ($env:CLAUDE_CODE_FORCE_RECOVERY_CLI -eq "1") {
    bun --env-file=.env ./src/localRecoveryCli.ts @args
} else {
    bun --env-file=.env ./src/entrypoints/cli.tsx @args
}
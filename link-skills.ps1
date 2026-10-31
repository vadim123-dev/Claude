# Links every skill under Skills\<group>\<name> into ~/.claude/skills\<name> as a directory junction.
# Safe to re-run: existing links are skipped, and a real folder with the same name is reported, not touched.

$target = Join-Path $env:USERPROFILE ".claude\skills"
New-Item -ItemType Directory -Force $target | Out-Null

Get-ChildItem (Join-Path $PSScriptRoot "Skills") -Directory | ForEach-Object {
    Get-ChildItem $_.FullName -Directory | Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") }
} | ForEach-Object {
    $link = Join-Path $target $_.Name
    if (-not (Test-Path $link)) {
        New-Item -ItemType Junction -Path $link -Target $_.FullName | Out-Null
        "linked   $($_.Name)"
    } elseif ((Get-Item $link).LinkType) {
        "ok       $($_.Name)"
    } else {
        "CONFLICT $($_.Name): a real folder already exists at $link"
    }
}

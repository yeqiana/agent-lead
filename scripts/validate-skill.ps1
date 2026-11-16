$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$required = @(
  'SKILL.md',
  'references/model-routing.md',
  '.agents/skills/agent-lead/SKILL.md',
  '.agents/skills/agent-lead/references/model-routing.md',
  'README.md',
  'LICENSE'
)
foreach ($relative in $required) {
  if (-not (Test-Path -LiteralPath (Join-Path $root $relative) -PathType Leaf)) {
    throw "Missing required file: $relative"
  }
}
$source = Join-Path $root 'SKILL.md'
$installed = Join-Path $root '.agents/skills/agent-lead/SKILL.md'
$ref = Join-Path $root 'references/model-routing.md'
$installedRef = Join-Path $root '.agents/skills/agent-lead/references/model-routing.md'
if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -ne
    (Get-FileHash -LiteralPath $installed -Algorithm SHA256).Hash) {
  throw 'Project skill differs from canonical SKILL.md'
}
if ((Get-FileHash -LiteralPath $ref -Algorithm SHA256).Hash -ne
    (Get-FileHash -LiteralPath $installedRef -Algorithm SHA256).Hash) {
  throw 'Project skill references differ from canonical references'
}
$text = [System.IO.File]::ReadAllText($source, [System.Text.Encoding]::UTF8)
$frontmatter = [regex]::Match($text, '(?s)\A---\r?\n(.*?)\r?\n---(?:\r?\n|\z)')
if (-not $frontmatter.Success) { throw 'Invalid SKILL.md YAML frontmatter' }
if ($frontmatter.Groups[1].Value -notmatch '(?m)^name: agent-lead\s*$') {
  throw 'Skill name must be agent-lead'
}
$description = [regex]::Match($frontmatter.Groups[1].Value, '(?m)^description:\s*(.+)$')
if (-not $description.Success -or $description.Groups[1].Value.Length -gt 1024) {
  throw 'Missing or oversized skill description'
}
$links = [regex]::Matches($text, '\]\((references/[^)#]+)(?:#[^)]*)?\)')
foreach ($link in $links) {
  $relative = $link.Groups[1].Value
  if (-not (Test-Path -LiteralPath (Join-Path $root $relative) -PathType Leaf)) {
    throw "Broken skill link: $relative"
  }
}
$license = [System.IO.File]::ReadAllText((Join-Path $root 'LICENSE'), [System.Text.Encoding]::UTF8)
if (-not $license.StartsWith('MIT License')) { throw 'Unexpected license text' }
Write-Output 'Agent Lead skill package validation: PASS'

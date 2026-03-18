# Jamie Rigling Mediation - Quick Deployment Verification Script
# Run this after DNS is configured to verify the deployment

$ErrorActionPreference = "Continue"
$domain = "minnesotapeace.com"
$checks = @()

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Minnesota Peace Deployment Checker" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 1. DNS Check
Write-Host "[1/8] Checking DNS resolution..." -ForegroundColor Yellow
try {
    $dns = Resolve-DnsName $domain -ErrorAction Stop
    if ($dns) {
        Write-Host "  ✓ DNS resolves successfully" -ForegroundColor Green
        $checks += @{Test="DNS Resolution"; Status="PASS"}
    }
} catch {
    Write-Host "  ✗ DNS not configured yet" -ForegroundColor Red
    Write-Host "    → Point $domain to Cloudflare Pages first" -ForegroundColor Gray
    $checks += @{Test="DNS Resolution"; Status="FAIL"}
}

# 2. HTTPS Check
Write-Host "`n[2/8] Checking HTTPS certificate..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "https://$domain" -Method Head -UseBasicParsing -ErrorAction Stop
    if ($response.StatusCode -eq 200) {
        Write-Host "  ✓ HTTPS working (SSL active)" -ForegroundColor Green
        $checks += @{Test="HTTPS/SSL"; Status="PASS"}
    }
} catch {
    Write-Host "  ✗ HTTPS not accessible yet" -ForegroundColor Red
    Write-Host "    → Wait 5-10 minutes after DNS configuration" -ForegroundColor Gray
    $checks += @{Test="HTTPS/SSL"; Status="FAIL"}
}

# 3. Sitemap Check
Write-Host "`n[3/8] Checking sitemap.xml..." -ForegroundColor Yellow
try {
    $sitemap = Invoke-WebRequest -Uri "https://$domain/sitemap.xml" -UseBasicParsing -ErrorAction Stop
    if ($sitemap.Content -match "urlset") {
        Write-Host "  ✓ Sitemap accessible" -ForegroundColor Green
        $checks += @{Test="Sitemap"; Status="PASS"}
    }
} catch {
    Write-Host "  ✗ Sitemap not found" -ForegroundColor Red
    $checks += @{Test="Sitemap"; Status="FAIL"}
}

# 4. Robots.txt Check
Write-Host "`n[4/8] Checking robots.txt..." -ForegroundColor Yellow
try {
    $robots = Invoke-WebRequest -Uri "https://$domain/robots.txt" -UseBasicParsing -ErrorAction Stop
    if ($robots.Content -match "Sitemap") {
        Write-Host "  ✓ Robots.txt accessible" -ForegroundColor Green
        $checks += @{Test="Robots.txt"; Status="PASS"}
    }
} catch {
    Write-Host "  ✗ Robots.txt not found" -ForegroundColor Red
    $checks += @{Test="Robots.txt"; Status="FAIL"}
}

# 5. Structured Data Check
Write-Host "`n[5/8] Checking structured data..." -ForegroundColor Yellow
try {
    $html = Invoke-WebRequest -Uri "https://$domain" -UseBasicParsing -ErrorAction Stop
    if ($html.Content -match "application/ld\+json" -and $html.Content -match "ProfessionalService") {
        Write-Host "  ✓ Structured data (JSON-LD) present" -ForegroundColor Green
        $checks += @{Test="Structured Data"; Status="PASS"}
    } else {
        Write-Host "  ⚠ Structured data not detected" -ForegroundColor Yellow
        $checks += @{Test="Structured Data"; Status="WARN"}
    }
} catch {
    Write-Host "  ✗ Cannot verify structured data" -ForegroundColor Red
    $checks += @{Test="Structured Data"; Status="FAIL"}
}

# 6. WebP Images Check
Write-Host "`n[6/8] Checking WebP image optimization..." -ForegroundColor Yellow
try {
    $html = Invoke-WebRequest -Uri "https://$domain" -UseBasicParsing -ErrorAction Stop
    $webpCount = ([regex]::Matches($html.Content, "\.webp")).Count
    if ($webpCount -ge 3) {
        Write-Host "  ✓ WebP images deployed ($webpCount references found)" -ForegroundColor Green
        $checks += @{Test="WebP Images"; Status="PASS"}
    } else {
        Write-Host "  ⚠ WebP images may not be loading" -ForegroundColor Yellow
        $checks += @{Test="WebP Images"; Status="WARN"}
    }
} catch {
    Write-Host "  ✗ Cannot verify images" -ForegroundColor Red
    $checks += @{Test="WebP Images"; Status="FAIL"}
}

# 7. Calendly Check
Write-Host "`n[7/8] Checking Calendly integration..." -ForegroundColor Yellow
try {
    $html = Invoke-WebRequest -Uri "https://$domain" -UseBasicParsing -ErrorAction Stop
    if ($html.Content -match "jamieriglingmediation-1/30min") {
        Write-Host "  ✓ Calendly URL configured (production)" -ForegroundColor Green
        $checks += @{Test="Calendly"; Status="PASS"}
    } else {
        Write-Host "  ⚠ Calendly URL may be incorrect" -ForegroundColor Yellow
        $checks += @{Test="Calendly"; Status="WARN"}
    }
} catch {
    Write-Host "  ✗ Cannot verify Calendly" -ForegroundColor Red
    $checks += @{Test="Calendly"; Status="FAIL"}
}

# 8. GA4 Check
Write-Host "`n[8/8] Checking Google Analytics..." -ForegroundColor Yellow
try {
    $html = Invoke-WebRequest -Uri "https://$domain" -UseBasicParsing -ErrorAction Stop
    if ($html.Content -match "G-WM6Q66W9W0") {
        Write-Host "  ✓ GA4 tracking code present" -ForegroundColor Green
        $checks += @{Test="Analytics"; Status="PASS"}
    } else {
        Write-Host "  ⚠ GA4 tracking code not found" -ForegroundColor Yellow
        $checks += @{Test="Analytics"; Status="WARN"}
    }
} catch {
    Write-Host "  ✗ Cannot verify analytics" -ForegroundColor Red
    $checks += @{Test="Analytics"; Status="FAIL"}
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  VERIFICATION SUMMARY" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$passed = ($checks | Where-Object {$_.Status -eq "PASS"}).Count
$warned = ($checks | Where-Object {$_.Status -eq "WARN"}).Count
$failed = ($checks | Where-Object {$_.Status -eq "FAIL"}).Count
$total = $checks.Count

Write-Host "  ✓ Passed:  $passed/$total" -ForegroundColor Green
if ($warned -gt 0) { Write-Host "  ⚠ Warnings: $warned/$total" -ForegroundColor Yellow }
if ($failed -gt 0) { Write-Host "  ✗ Failed:  $failed/$total" -ForegroundColor Red }

Write-Host "`n----------------------------------------`n"

if ($passed -eq $total) {
    Write-Host "🎉 ALL CHECKS PASSED!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "  1. Submit sitemap to Google Search Console" -ForegroundColor Gray
    Write-Host "  2. Test site on mobile devices" -ForegroundColor Gray
    Write-Host "  3. Claim Google Business Profile" -ForegroundColor Gray
    Write-Host "  4. Monitor analytics for 24-48 hours`n" -ForegroundColor Gray
} elseif ($failed -eq 0 -and $warned -gt 0) {
    Write-Host "⚠️  DEPLOYMENT MOSTLY SUCCESSFUL (Minor Issues)" -ForegroundColor Yellow
    Write-Host "`nReview warnings and verify manually.`n" -ForegroundColor Gray
} else {
    Write-Host "❌ DEPLOYMENT INCOMPLETE" -ForegroundColor Red
    Write-Host "`nAction Required:" -ForegroundColor Cyan
    Write-Host "  1. Configure DNS if not done" -ForegroundColor Gray
    Write-Host "  2. Wait 5-10 minutes and re-run this script" -ForegroundColor Gray
    Write-Host "  3. Check Cloudflare Pages deployment logs`n" -ForegroundColor Gray
}

# Validation Tool Links
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  VALIDATION TOOLS" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
Write-Host "Test structured data:" -ForegroundColor Yellow
Write-Host "  https://search.google.com/test/rich-results?url=https://$domain`n" -ForegroundColor Gray
Write-Host "Test performance:" -ForegroundColor Yellow
Write-Host "  https://pagespeed.web.dev/analysis?url=https://$domain`n" -ForegroundColor Gray
Write-Host "Submit sitemap:" -ForegroundColor Yellow
Write-Host "  https://search.google.com/search-console`n" -ForegroundColor Gray

Write-Host "========================================`n" -ForegroundColor Cyan

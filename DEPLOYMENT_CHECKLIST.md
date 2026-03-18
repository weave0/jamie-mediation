# Jamie Rigling Mediation - Deployment & SEO Verification Checklist

**Deploy Date:** March 18, 2026
**GitHub Repo:** https://github.com/weave0/jamie-mediation
**Production URL:** https://minnesotapeace.com (pending DNS configuration)

---

## ✅ Completed Deployments

### **1. Content & SEO Overhaul** (Commit: 1c24198)

- ✅ Enhanced meta tags with geo-targeting (Maple Grove, Twin Cities)
- ✅ Added structured data (JSON-LD): ProfessionalService, Person, WebPage, WebSite schemas
- ✅ Added About Jamie section with profile photo
- ✅ Added pull-quote callout: "Words are like bullets..."
- ✅ Added Veterans/Military Families callout
- ✅ Added Referral block for attorneys/therapists
- ✅ Fixed Calendly URL to production
- ✅ Expanded keywords: 15+ long-tail SEO targets

### **2. Performance Optimization** (Commit: f72461b)

- ✅ Converted all images to WebP format
  - Jamie Profile Square: 1538KB → 69KB (-95.5%)
  - Jamie Profile: 2210KB → 102KB (-95.4%)
  - Hero background: 1522KB → 20KB (-98.7%)
  - Process image: 2120KB → 56KB (-97.4%)
  - **Total saved: ~7.1MB**
- ✅ Added `<picture>` elements with PNG fallbacks
- ✅ Added WebP detection script
- ✅ Created sitemap.xml with image sitemap
- ✅ Created robots.txt

---

## 🚨 CRITICAL NEXT STEP: DNS Configuration

**The site is built and deployed, but `minnesotapeace.com` does NOT point to Cloudflare Pages yet.**

### **Option A: Cloudflare-Managed DNS** (Recommended)

If the domain is already in Cloudflare:

1. Go to **Cloudflare Dashboard** → Domains → `minnesotapeace.com`
2. Add **CNAME record**:
   ```
   Name:   @
   Target: jamie-mediation.pages.dev
   Proxy:  ✓ (Proxied/orange cloud)
   ```
3. Add **CNAME record** for www:
   ```
   Name:   www
   Target: minnesotapeace.com
   Proxy:  ✓ (Proxied)
   ```

### **Option B: External DNS Provider**

If the domain is at another registrar:

1. In **Cloudflare Pages** → Your project → **Custom domains**
2. Add `minnesotapeace.com` and follow Cloudflare's DNS instructions
3. Add the provided CNAME or A records to your DNS provider
4. Wait 5-60 minutes for DNS propagation

### **Verify DNS**

```powershell
nslookup minnesotapeace.com
# Should resolve to Cloudflare IPs
```

---

## 📋 Post-Deployment Verification Checklist

### **Immediate (Within 24 Hours)**

#### **1. Basic Site Checks**

```powershell
# Test HTTPS
curl -I https://minnesotapeace.com

# Test sitemap
curl https://minnesotapeace.com/sitemap.xml

# Test robots.txt
curl https://minnesotapeace.com/robots.txt
```

- [ ] Site loads over HTTPS (SSL certificate active)
- [ ] All images load correctly (check WebP with DevTools)
- [ ] Navigation works (smooth scroll to sections)
- [ ] Calendly widget appears in Booking section
- [ ] Contact information displays correctly
- [ ] Mobile responsive on 3+ devices

#### **2. Structured Data Validation**

Test tools:

- **Rich Results Test:** https://search.google.com/test/rich-results
- **Schema Validator:** https://validator.schema.org/

Expected schemas to validate:

- [ ] ProfessionalService (business info, services, address)
- [ ] Person (Jamie Rigling credentials)
- [ ] WebPage (page metadata)
- [ ] WebSite (site-level info)

#### **3. Performance Testing**

- **PageSpeed Insights:** https://pagespeed.web.dev/
- **GTmetrix:** https://gtmetrix.com/

Target metrics:

- [ ] Largest Contentful Paint (LCP) < 2.5s
- [ ] First Input Delay (FID) < 100ms
- [ ] Cumulative Layout Shift (CLS) < 0.1
- [ ] Performance score > 90

#### **4. Google Search Console Setup**

1. Go to: https://search.google.com/search-console
2. Add property: `minnesotapeace.com`
3. Verify ownership (DNS TXT record or HTML file)
4. Submit sitemap: `https://minnesotapeace.com/sitemap.xml`
5. Request indexing for homepage

Expected indexing timeline:

- **Day 1-3:** Homepage indexed
- **Week 1:** Structured data appears in Search Console
- **Week 2-4:** Rich snippets start appearing in search results

---

### **Week 1 Actions**

#### **5. Google Business Profile (Critical for Local SEO)**

1. Go to: https://business.google.com
2. Create profile:
   - **Business name:** Jamie Rigling Mediation (or Minnesota Peace)
   - **Category:** Mediator, Family Counselor, Social Services Organization
   - **Address:** Maple Grove, MN (use actual address or service area)
   - **Phone:** (507) 383-7088
   - **Website:** https://minnesotapeace.com
   - **Hours:** Monday-Friday 9AM-5PM
3. Verify by postcard (takes 5-7 days)
4. Add photos: Jamie's profile photo, office/workspace
5. Write business description using keywords from meta tags

**Why this matters:** Google Business Profile is the #1 factor for local SEO rankings.

#### **6. Analytics Verification**

- [ ] GA4 tracking code fires correctly (check Real-Time reports)
- [ ] Set up conversion goal for Calendly clicks
- [ ] Set up conversion goal for phone/email clicks in Contact section

#### **7. Image Optimization Verification**

Open DevTools → Network tab:

- [ ] Hero background loads `hero-bg.webp` (not .png)
- [ ] Jamie Profile loads `Jamie Profile Square.webp`
- [ ] Process image loads `process.webp`
- [ ] Total page weight < 500KB (down from ~8MB)

---

### **Month 1 Actions**

#### **8. Backlink Building**

Submit to legal directories:

- [ ] **Avvo:** https://www.avvo.com/
- [ ] **FindLaw:** https://www.findlaw.com/
- [ ] **Martindale-Hubbell:** https://www.martindale.com/
- [ ] **Minnesota State Bar Association:** https://www.mnbar.org/
- [ ] **Better Business Bureau:** https://www.bbb.org/

Veteran-friendly directories:

- [ ] **Military OneSource:** https://www.militaryonesource.mil/
- [ ] **VA Caregiver Support:** https://www.caregiver.va.gov/

#### **9. Keyword Ranking Monitoring**

Track these in Google Search Console (Position tab):

- "mediator Maple Grove MN"
- "divorce mediator Twin Cities"
- "family mediation Minnesota"
- "conscious separation Minnesota"
- "veteran mediation Minnesota"
- "trauma-informed mediator"
- "low-cost divorce alternatives Minnesota"

Target outcomes (90 days):

- Top 5 for "Jamie Rigling mediator"
- Top 20 for "mediator Maple Grove"
- Top 30 for "divorce mediator Twin Cities"

#### **10. Review Schema Setup (Future)**

Once Jamie has client testimonials:

1. Add **Review** schema to index.html
2. Display reviews on homepage
3. Request reviews from satisfied clients
4. Link to Google Business Profile for more reviews

---

## 🎯 SEO Performance Benchmarks

### **Immediate Impact (Days 1-7)**

- Google indexes homepage
- Structured data visible in Search Console
- Rich snippets eligible for search results

### **30 Days**

- Top 10 for branded search ("Jamie Rigling mediator")
- Local pack may appear if GBP claimed
- 10-50 organic impressions/day

### **60 Days**

- Top 20-30 for "mediator Maple Grove MN"
- Rich snippets appear in search results
- 50-150 organic impressions/day
- 5-15 clicks/day

### **90 Days**

- Top 10 for "divorce mediator Twin Cities" (if backlinks built)
- Top 5 for "conscious separation Minnesota"
- Knowledge Panel may appear
- 100-300 organic impressions/day
- 15-40 clicks/day

---

## 🛠️ Testing Tools Quick Reference

| Tool                        | Purpose                  | URL                                         |
| --------------------------- | ------------------------ | ------------------------------------------- |
| **Rich Results Test**       | Validate structured data | https://search.google.com/test/rich-results |
| **Schema Validator**        | Validate JSON-LD syntax  | https://validator.schema.org/               |
| **PageSpeed Insights**      | Core Web Vitals          | https://pagespeed.web.dev/                  |
| **GTmetrix**                | Performance analysis     | https://gtmetrix.com/                       |
| **Google Search Console**   | Index status, rankings   | https://search.google.com/search-console    |
| **Google Business Profile** | Local SEO                | https://business.google.com                 |
| **GA4 Real-Time**           | Live traffic monitoring  | https://analytics.google.com/analytics/web/ |
| **Cloudflare Pages**        | Deployment logs          | https://dash.cloudflare.com                 |

---

## 📞 Configuration Status

| Item                  | Status                      | Notes                                               |
| --------------------- | --------------------------- | --------------------------------------------------- |
| **DNS**               | ⚠️ Pending                  | Must point `minnesotapeace.com` to Cloudflare Pages |
| **SSL Certificate**   | ⏳ Auto-provision           | Activates ~5 min after DNS configured               |
| **Calendly URL**      | ✅ Production               | `jamieriglingmediation-1/30min`                     |
| **Contact Email**     | ✅ jamie@minnesotapeace.com | Verify email is active                              |
| **Phone Number**      | ✅ (507) 383-7088           | Verify number is active                             |
| **Analytics**         | ✅ GA4 G-WM6Q66W9W0         | Check Real-Time after DNS live                      |
| **Sitemap**           | ✅ Deployed                 | Submit to Search Console after DNS                  |
| **Google Business**   | ❌ Not claimed              | HIGH PRIORITY                                       |
| **Domain Auto-Renew** | ⚠️ Unknown                  | Verify with registrar                               |

---

## 🚀 Deployment Commands Quick Reference

```powershell
# Check git status
cd "Z:\GFD\GFD Dev Projects\jamie-mediation"
git status
git log --oneline -5

# Test locally (if needed)
npx http-server . -p 3000

# Deploy new changes
git add .
git commit -m "description"
git push origin main

# Check Cloudflare deployment
# Visit: https://dash.cloudflare.com → Pages → jamie-mediation
```

---

## ✅ Commit History

| Commit      | Changes                                 | File Impact                                              |
| ----------- | --------------------------------------- | -------------------------------------------------------- |
| **1c24198** | SEO overhaul + content additions        | +316 lines (structured data, About, Veterans, Referrals) |
| **f72461b** | Image optimization + SEO infrastructure | +143 lines (WebP, sitemap, robots.txt)                   |

**Total enhancement:** 459 lines of strategic SEO and performance code

---

## 📝 Next Steps Summary

**IMMEDIATE (Do Today):**

1. ⚠️ Configure DNS for `minnesotapeace.com` → Cloudflare Pages
2. ✅ Verify site loads over HTTPS
3. ✅ Test structured data validators
4. ✅ Submit sitemap to Google Search Console

**THIS WEEK:** 5. ⚠️ Claim Google Business Profile (CRITICAL for local SEO) 6. ✅ Verify GA4 tracking 7. ✅ Run PageSpeed Insights 8. ✅ Test mobile responsiveness

**THIS MONTH:** 9. 🔗 Submit to 5+ legal directories 10. 📊 Monitor keyword rankings in Search Console 11. 📧 Set up professional email if not done 12. 📝 Add client testimonials (if available)

---

**Questions? Issues?** Check Cloudflare Pages deployment logs or contact deployment team.

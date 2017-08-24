From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 24 Aug 2017 13:07:57 +0200
Subject: [LTP] [PATCH] CVE: Add some existing tests to runtest file
In-Reply-To: <20170824110803.9994-1-rpalethorpe@suse.com>
References: <20170824110803.9994-1-rpalethorpe@suse.com>
Message-ID: <20170824110803.9994-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add some CVE tests to the CVE runtest file from before it was created.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 6e3e52d3a..6d7cb3f76 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -1,6 +1,10 @@
 # Tests which check for vulnerabilities by CVE number
+cve-2011-0999 thp01 -I 120
+cve-2011-2183 ksm05 -I 10
+cve-2011-2496 vma03
 cve-2012-0957 cve-2012-0957
 cve-2014-0196 cve-2014-0196
+cve-2015-0235 gethostbyname_r01
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7117 cve-2016-7117
-- 
2.13.3


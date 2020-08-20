From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Aug 2020 12:02:38 +0200
Subject: [LTP] [PATCH 1/1] tst_kvcmp: Fix parsing format for /etc/os-release
Message-ID: <20200820100238.15925-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need to strip double quotes.
Also for openSUSE Tumbleweed, which contains ID="opensuse-tumbleweed"
it "\"%s\"" does not remove trailing double quote, thus match all but
double quote.

Fixes: e2e60a39b ("lib/tst_kvercmp: Add support /etc/os-release")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_kvercmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 185a5c39c..7e980e076 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -146,7 +146,8 @@ const char *tst_kvcmp_distname(const char *kver)
 		return "RHEL6";
 
 	if (access(OSRELEASE_PATH, F_OK) != -1) {
-		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
+		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=\"%[^\"]\"",
+				      distname);
 
 		while (*p) {
 			*p = toupper((unsigned char)*p);
-- 
2.28.0


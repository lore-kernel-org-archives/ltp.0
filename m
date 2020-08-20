From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Aug 2020 15:30:32 +0200
Subject: [LTP] [PATCH v3 1/1] tst_kvcmp: Strip double quotes when parsing
 /etc/os-release
Message-ID: <20200820133032.16840-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ID is normally without double quotes, e.g.: ID=debian

But at least SLES and openSUSE contain double quotes, e.g.:
ID="opensuse-tumbleweed"

thus optionally strip the double quotes after scanning them.

Fixes: e2e60a39b ("lib/tst_kvercmp: Add support /etc/os-release")

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_kvercmp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 185a5c39c..5d56e30b9 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -131,6 +131,7 @@ int tst_kvexcmp(const char *tst_exv, const char *cur_ver)
 const char *tst_kvcmp_distname(const char *kver)
 {
 	static char distname[64];
+	char *ret = distname;
 	char *p = distname;
 
 	if (strstr(kver, ".el5uek"))
@@ -148,12 +149,21 @@ const char *tst_kvcmp_distname(const char *kver)
 	if (access(OSRELEASE_PATH, F_OK) != -1) {
 		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
 
+		if (p[0] == '"') {
+			ret = distname + 1;
+			p = ret;
+		}
+
 		while (*p) {
+			if (*p == '"') {
+				*p = 0;
+				break;
+			}
 			*p = toupper((unsigned char)*p);
 			p++;
 		}
 
-		return distname;
+		return ret;
 	}
 
 	return NULL;
-- 
2.28.0


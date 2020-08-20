From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Aug 2020 14:00:51 +0200
Subject: [LTP] [PATCH v2 1/1] tst_kvcmp: Strip double quotes when parsing
 /etc/os-release
Message-ID: <20200820120051.331-1-pvorel@suse.cz>
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
 lib/tst_kvercmp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 185a5c39c..dfd81ac83 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -148,6 +148,12 @@ const char *tst_kvcmp_distname(const char *kver)
 	if (access(OSRELEASE_PATH, F_OK) != -1) {
 		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
 
+		if (p[0] == '"')
+			memmove(p, p + 1, strlen(p));
+
+		if (p[strlen(p) - 1] == '"')
+			p[strlen(p) - 1] = '\0';
+
 		while (*p) {
 			*p = toupper((unsigned char)*p);
 			p++;
-- 
2.28.0


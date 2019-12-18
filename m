From: Pengfei Xu <pengfei.xu@intel.com>
Date: Wed, 18 Dec 2019 20:25:03 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_kconfig.c: add or select kconfig function
Message-ID: <20191218122504.9985-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add "or" select kconfig function:
  For example, umip kconfig changed from "CONFIG_X86_INTEL_UMIP=y"
to "CONFIG_X86_UMIP=y": as before v5.4 mainline kernel used
kconfig "CONFIG_X86_INTEL_UMIP=y", after v5.5 mainline kernel would use
"CONFIG_X86_UMIP=y".
  We could fill "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y" in needs_kconfigs
to check umip kconfig item, which actually is the same item.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 lib/tst_kconfig.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 4b51413e5..91c0a821b 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -167,7 +167,12 @@ void tst_kconfig_read(const char *const *kconfigs,
 	struct match matches[cnt];
 	FILE *fp;
 	unsigned int i, j;
-	char buf[1024];
+	char buf[1024], kconfig_multi[100];
+	char *kconfig_token = NULL, *p_left = NULL;
+
+	fp = open_kconfig();
+	if (!fp)
+		tst_brk(TBROK, "Cannot parse kernel .config");
 
 	for (i = 0; i < cnt; i++) {
 		const char *val = strchr(kconfigs[i], '=');
@@ -178,32 +183,38 @@ void tst_kconfig_read(const char *const *kconfigs,
 		matches[i].match = 0;
 		matches[i].len = strlen(kconfigs[i]);
 
-		if (val) {
+		if (val)
 			matches[i].val = val + 1;
-			matches[i].len -= strlen(val);
-		}
 
 		results[i].match = 0;
 		results[i].value = NULL;
-	}
 
-	fp = open_kconfig();
-	if (!fp)
-		tst_brk(TBROK, "Cannot parse kernel .config");
+		while (fgets(buf, sizeof(buf), fp)) {
 
-	while (fgets(buf, sizeof(buf), fp)) {
-		for (i = 0; i < cnt; i++) {
-			if (match(&matches[i], kconfigs[i], &results[i], buf)) {
-				for (j = 0; j < cnt; j++) {
-					if (matches[j].match)
-						break;
-				}
+			memset(kconfig_multi, 0, sizeof(kconfig_multi));
+			/* strtok_r will split kconfigs[i] to multi string, so copy it */
+			memcpy(kconfig_multi, kconfigs[i], strlen(kconfigs[i]));
+
+			kconfig_token = strtok_r(kconfig_multi, "|=", &p_left);
+			while (kconfig_token != NULL) {
+				if (strncmp("CONFIG_", kconfig_token, 7))
+					tst_brk(TBROK, "Invalid config string '%s'", kconfig_token);
+				matches[i].len = strlen(kconfig_token);
+				if (match(&matches[i], kconfig_token, &results[i], buf)) {
+					for (j = 0; j < cnt; j++) {
+						if (matches[j].match)
+							break;
+					}
 
 				if (j == cnt)
 					goto exit;
+				}
+				kconfig_token = strtok_r(NULL, "|=", &p_left);
+				/* avoid to use after "=" string */
+				if (strlen(p_left) == 0)
+					break;
 			}
 		}
-
 	}
 
 exit:
-- 
2.14.1


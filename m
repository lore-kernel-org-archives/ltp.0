From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Dec 2019 21:18:52 +0800
Subject: [LTP] [PATCH v4 1/4] lib/tst_kconfig.c: Add any kconfig to match
 the expected value function
Message-ID: <20191219131855.28799-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Example: CONFIG_X86_INTEL_UMIP=y for umip kconfig before and v5.4
           mainline kernel.
         CONFIG_X86_UMIP=y for umip kconfig after v5.5 mainline kernel.
Format: CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 lib/tst_kconfig.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 4b51413e5..74c46ebec 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -167,7 +167,8 @@ void tst_kconfig_read(const char *const *kconfigs,
 	struct match matches[cnt];
 	FILE *fp;
 	unsigned int i, j;
-	char buf[1024];
+	char buf[1024], kconfig_multi[100];
+	char *kconfig_token = NULL, *p_left = NULL;
 
 	for (i = 0; i < cnt; i++) {
 		const char *val = strchr(kconfigs[i], '=');
@@ -176,12 +177,9 @@ void tst_kconfig_read(const char *const *kconfigs,
 			tst_brk(TBROK, "Invalid config string '%s'", kconfigs[i]);
 
 		matches[i].match = 0;
-		matches[i].len = strlen(kconfigs[i]);
 
-		if (val) {
+		if (val)
 			matches[i].val = val + 1;
-			matches[i].len -= strlen(val);
-		}
 
 		results[i].match = 0;
 		results[i].value = NULL;
@@ -193,17 +191,29 @@ void tst_kconfig_read(const char *const *kconfigs,
 
 	while (fgets(buf, sizeof(buf), fp)) {
 		for (i = 0; i < cnt; i++) {
-			if (match(&matches[i], kconfigs[i], &results[i], buf)) {
-				for (j = 0; j < cnt; j++) {
-					if (matches[j].match)
-						break;
+			memset(kconfig_multi, 0, sizeof(kconfig_multi));
+			/* strtok_r will split kconfigs[i] to multi string, so copy it */
+			memcpy(kconfig_multi, kconfigs[i], strlen(kconfigs[i]));
+			kconfig_token = strtok_r(kconfig_multi, "|=", &p_left);
+
+			while (kconfig_token != NULL) {
+				if (strncmp("CONFIG_", kconfig_token, 7))
+					tst_brk(TBROK, "Invalid config string '%s'", kconfig_token);
+				matches[i].len = strlen(kconfig_token);
+				if (match(&matches[i], kconfig_token, &results[i], buf)) {
+					for (j = 0; j < cnt; j++) {
+						if (matches[j].match)
+							break;
+					}
 				}
-
-				if (j == cnt)
-					goto exit;
+				kconfig_token = strtok_r(NULL, "|=", &p_left);
+				/* avoid to use after "=" string */
+				if (strlen(p_left) == 0)
+					break;
 			}
+			if (j == cnt)
+				goto exit;
 		}
-
 	}
 
 exit:
-- 
2.14.1


From: Yang Xu <xuyang_jy_0410@163.com>
Date: Fri, 30 Oct 2020 00:35:44 +0800
Subject: [LTP] [PATCH 1/2] tst_kvercmp: Add rhel7,8 support
Message-ID: <20201029163545.9829-1-xuyang_jy_0410@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang_jy_0410@163.com>
---
 lib/tst_kvercmp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 5d56e30b9..8bf65d309 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -146,6 +146,12 @@ const char *tst_kvcmp_distname(const char *kver)
 	if (strstr(kver, ".el6"))
 		return "RHEL6";
 
+	if (strstr(kver, ".el7"))
+		return "RHEL7";
+
+	if (strstr(kver, ".el8"))
+		return "RHEL8";
+
 	if (access(OSRELEASE_PATH, F_OK) != -1) {
 		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
 
-- 
2.18.1



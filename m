From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Wed, 30 Dec 2020 18:48:56 +0300
Subject: [LTP] [PATCH v1] include/tst_cgroup.h: Replace hardcoded cgroup
 paths
Message-ID: <20201230154856.26252-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Macros PATH_TMP_CG_CST and PATH_TMP_CG_MEM defined cgroup
temporary directory paths to be in /tmp that can be a mount point.

Enable an option to set PATH_TMP_CG_CST and PATH_TMP_CG_MEM
through TMPDIR environment variable keeping old paths as default ones.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 include/tst_cgroup.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index bfd848260..0f7db5487 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -7,8 +7,9 @@
 #ifndef TST_CGROUP_H
 #define TST_CGROUP_H
 
-#define PATH_TMP_CG_MEM	"/tmp/cgroup_mem"
-#define PATH_TMP_CG_CST	"/tmp/cgroup_cst"
+#define PATH_BASE (getenv("TMPDIR") ? getenv("TMPDIR") : "/tmp")
+#define PATH_TMP_CG_CST (strcat(PATH_BASE, "/cgroup_cst"))
+#define PATH_TMP_CG_MEM (strcat(PATH_BASE, "/cgroup_mem"))
 
 enum tst_cgroup_ver {
 	TST_CGROUP_V1 = 1,
-- 
2.26.2


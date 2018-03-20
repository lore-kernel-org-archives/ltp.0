From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 20 Mar 2018 16:02:31 +0300
Subject: [LTP] [PATCH V2 2/2] ksm: perform cleanup actions only when they
	are actually required
In-Reply-To: <1521550951-8124-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20180320120134.GB9226@ai>
 <1521550951-8124-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1521550951-8124-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This one is similar to commit 8ae3916674fa
("mem/oom, tunable: perform cleanup actions only when they are actually required")
i.e. we are making sure that ksm tests do not revert any not yet performed
actions.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/mem/ksm/ksm02.c |    6 +++++-
 testcases/kernel/mem/ksm/ksm03.c |    6 +++++-
 testcases/kernel/mem/ksm/ksm04.c |   11 +++++++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 03b44c0..22c78cb 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -59,6 +59,8 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
+static int cpuset_mounted;
+
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -88,7 +90,8 @@ static void cleanup(void)
 
 	restore_max_page_sharing();
 
-	umount_mem(CPATH, CPATH_NEW);
+	if (cpuset_mounted)
+		umount_mem(CPATH, CPATH_NEW);
 }
 
 static void setup(void)
@@ -106,6 +109,7 @@ static void setup(void)
 	}
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	cpuset_mounted = 1;
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 51cc923..284f4ec 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -59,6 +59,8 @@
 #include "mem.h"
 #include "ksm_common.h"
 
+static int memcg_mounted;
+
 static void verify_ksm(void)
 {
 	write_memcg();
@@ -79,6 +81,7 @@ static void setup(void)
 	save_max_page_sharing();
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	memcg_mounted = 1;
 }
 
 static void cleanup(void)
@@ -89,7 +92,8 @@ static void cleanup(void)
 
 	restore_max_page_sharing();
 
-	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	if (memcg_mounted)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 835222f..9ffef4d 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -59,6 +59,9 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
+static int cpuset_mounted;
+static int memcg_mounted;
+
 static void verify_ksm(void)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -90,8 +93,10 @@ static void cleanup(void)
 
 	restore_max_page_sharing();
 
-	umount_mem(CPATH, CPATH_NEW);
-	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	if (cpuset_mounted)
+		umount_mem(CPATH, CPATH_NEW);
+	if (memcg_mounted)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
 static void setup(void)
@@ -109,7 +114,9 @@ static void setup(void)
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	cpuset_mounted = 1;
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	memcg_mounted = 1;
 }
 
 static struct tst_test test = {
-- 
1.7.1


From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Dec 2017 15:44:44 +0800
Subject: [LTP] [PATCH] mem/oom03,
	05: Fix failure when setting memory.memsw.limit_in_bytes
Message-ID: <1513237484-30831-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We got the following error when running oom03 or oom05 on RHEL7.5Alpha
----------------------------------------------------------------------
...
mem.c:230: INFO: start OOM testing for KSM pages.
...
mem.c:145: PASS: victim signalled: (9) SIGKILL
safe_file_ops.c:301: BROK: Failed to close FILE '/dev/cgroup/1/memory.memsw.limit_in_bytes' at oom03.c:56: EBUSY
...
----------------------------------------------------------------------

After testing oom with memory.limit_in_bytes, the value of
memory.memsw.usage_in_bytes may be increased and exceed (1UL<<30)
defined by TESTMEM variable.  In this case, subsequently setting
memory.memsw.limit_in_bytes to (1UL<<30) gets EBUSY.  We could
reinitialize memory cgroup to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/include/mem.h | 1 +
 testcases/kernel/mem/lib/mem.c     | 7 +++++++
 testcases/kernel/mem/oom/oom03.c   | 5 ++---
 testcases/kernel/mem/oom/oom05.c   | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 95d0bda..6aad1c5 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -80,6 +80,7 @@ void write_cpuset_files(char *prefix, char *filename, char *buf);
 void write_cpusets(long nd);
 void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
 void umount_mem(char *path, char *path_new);
+void remount_memcg(void);
 
 /* shared */
 unsigned int get_a_numa_node(void);
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7f2099b..84fe00a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -918,3 +918,10 @@ int range_is_mapped(unsigned long low, unsigned long high)
 	fclose(fp);
 	return 0;
 }
+
+void remount_memcg(void)
+{
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	write_memcg();
+}
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index c4b90c1..909c37b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -41,9 +41,6 @@ static void verify_oom(void)
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
-	SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
-	SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
-
 	testoom(0, 0, ENOMEM, 1);
 
 	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
@@ -53,6 +50,7 @@ static void verify_oom(void)
 		else
 			tst_brk(TBROK | TERRNO, "access");
 	} else {
+		remount_memcg();
 		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
 		testoom(0, 1, ENOMEM, 1);
 	}
@@ -71,6 +69,7 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	write_memcg();
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index eb24531..06129df 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -67,6 +67,7 @@ static void verify_oom(void)
 	}
 
 	if (swap_acc_on) {
+		remount_memcg();
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
 		SAFE_FILE_PRINTF(MEMCG_SW_LIMIT, "%ld", TESTMEM);
-- 
1.8.3.1




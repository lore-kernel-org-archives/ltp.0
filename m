From: Li Wang <liwang@redhat.com>
Date: Wed,  1 Nov 2017 13:15:22 +0800
Subject: [LTP] [PATCH v3 1/2] ltp: fix some frequent typoes
Message-ID: <20171101051523.373-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These are high-frequency easily misspelled words: kernel|memory|filesystem|network.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt                                  | 2 +-
 include/old/old_device.h                                         | 2 +-
 include/tst_safe_macros.h                                        | 2 +-
 testcases/kernel/containers/TEST_PLAN.txt                        | 2 +-
 testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh | 2 +-
 testcases/kernel/device-drivers/agp/kernel_space/tagp.c          | 2 +-
 testcases/kernel/device-drivers/agp/kernel_space/tagp.h          | 2 +-
 testcases/kernel/device-drivers/agp/user_space/user_tagp.c       | 2 +-
 testcases/kernel/fs/fs-bench/modaltr.sh                          | 2 +-
 testcases/network/iptables/iptables_tests.sh                     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index edc1f60..207eadd 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -822,7 +822,7 @@ Aligns the x to be next multiple of a. The a must be power of 2.
 2.2.12 Filesystem type detection
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Some tests are known to fail on certain filesytems (you cannot swap on TMPFS,
+Some tests are known to fail on certain filesystems (you cannot swap on TMPFS,
 there are unimplemented 'fcntl()' etc.).
 
 If your test needs to be skipped on certain filesystems, use the interface
diff --git a/include/old/old_device.h b/include/old/old_device.h
index 4dbb3ff..17da57e 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -21,7 +21,7 @@
 /*
  * Returns filesystem type to be used for the testing. Unless your test is
  * designed for specific filesystem you should use this function to the tested
- * filesytem.
+ * filesystem.
  *
  * If TST_DEV_FS_TYPE is set the function returns it's content,
  * otherwise default fs type hardcoded in the library is returned.
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9562005..ed9c73c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -406,7 +406,7 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 #define SAFE_EXECL(file, arg, ...) do {				\
        execl((file), (arg), ##__VA_ARGS__);			\
        tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,		\
-                "execlp(%s, %s, ...) failed", file, arg); 	\
+                "execl(%s, %s, ...) failed", file, arg); 	\
        } while (0)
 
 int safe_getpriority(const char *file, const int lineno, int which, id_t who);
diff --git a/testcases/kernel/containers/TEST_PLAN.txt b/testcases/kernel/containers/TEST_PLAN.txt
index 4b3d2bc..809abae 100644
--- a/testcases/kernel/containers/TEST_PLAN.txt
+++ b/testcases/kernel/containers/TEST_PLAN.txt
@@ -19,7 +19,7 @@ Following are tentative Testcases to be included into LTP-Containers in future:
 NAME						TENTATIVE-TIME
 =================================================================================
 PID NAMESPACES					(NEAR FUTURE)
-NETWROK NAMESPACES				(NEAR FUTURE)
+NETWORK NAMESPACES				(NEAR FUTURE)
 POSIX IPC NAMESPACES				(NEAR FUTURE)
 TTY+CONSOLE+DEVPTS NAMESPACES			(NEAR FUTURE)
 PROC+SYSFS ISOLATION				(NEAR FUTURE)
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 2c47a92..3bfc1da 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -21,7 +21,7 @@
 ################################################################################
 #
 # File :        memcg_stat_test.sh
-# Description:  Tests memroy.stat.
+# Description:  Tests memory.stat.
 # Author:       Peng Haitao <penght@cn.fujitsu.com>
 # History:      2012/01/16 - Created.
 #
diff --git a/testcases/kernel/device-drivers/agp/kernel_space/tagp.c b/testcases/kernel/device-drivers/agp/kernel_space/tagp.c
index 99e76f1..496c8a7 100644
--- a/testcases/kernel/device-drivers/agp/kernel_space/tagp.c
+++ b/testcases/kernel/device-drivers/agp/kernel_space/tagp.c
@@ -216,7 +216,7 @@ static int tagp_ioctl(struct inode *ino, struct file *f,
 	case TEST_GENERIC_FREE_GATT_TABLE:
 		rc = test_agp_generic_free_gatt_table();
 		break;
-	case TEST_GENERIC_INSERT_MEMROY:
+	case TEST_GENERIC_INSERT_MEMORY:
 		rc = test_agp_generic_insert_memory();
 		break;
 	case TEST_GENERIC_ALLOC_BY_TYPE:
diff --git a/testcases/kernel/device-drivers/agp/kernel_space/tagp.h b/testcases/kernel/device-drivers/agp/kernel_space/tagp.h
index 3df13dc..b7b6303 100644
--- a/testcases/kernel/device-drivers/agp/kernel_space/tagp.h
+++ b/testcases/kernel/device-drivers/agp/kernel_space/tagp.h
@@ -55,7 +55,7 @@
 #define TEST_NUM_ENTRIES			_IO(MAG_NUM, 12)
 #define TEST_GENERIC_CREATE_GATT_TABLE		_IO(MAG_NUM, 13)
 #define TEST_GENERIC_FREE_GATT_TABLE		_IO(MAG_NUM, 14)
-#define TEST_GENERIC_INSERT_MEMROY		_IO(MAG_NUM, 15)
+#define TEST_GENERIC_INSERT_MEMORY		_IO(MAG_NUM, 15)
 #define TEST_GENERIC_ALLOC_BY_TYPE		_IO(MAG_NUM, 16)
 #define TEST_GENERIC_ALLOC_PAGE			_IO(MAG_NUM, 17)
 #define TEST_ENABLE				_IO(MAG_NUM, 19)
diff --git a/testcases/kernel/device-drivers/agp/user_space/user_tagp.c b/testcases/kernel/device-drivers/agp/user_space/user_tagp.c
index 8d432b7..500067e 100644
--- a/testcases/kernel/device-drivers/agp/user_space/user_tagp.c
+++ b/testcases/kernel/device-drivers/agp/user_space/user_tagp.c
@@ -249,7 +249,7 @@ int main()
 		printf("Success on agp_generic_free_gatt_table\n");
 
 	/* make test calls for agp_generic_insert_memory */
-	if (ki_generic(tagp_fd, TEST_GENERIC_INSERT_MEMROY))
+	if (ki_generic(tagp_fd, TEST_GENERIC_INSERT_MEMORY))
 		printf("Fail on agp_generic_insert_memory\n");
 	else
 		printf("Success on agp_generic_insert_memory\n");
diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/fs-bench/modaltr.sh
index c4ea745..e44c17f 100755
--- a/testcases/kernel/fs/fs-bench/modaltr.sh
+++ b/testcases/kernel/fs/fs-bench/modaltr.sh
@@ -6,7 +6,7 @@
 # 4.you should have fs-bench utility (http://h2np.net/tools/fs-bench-0.2.tar.gz)
 # 5.results will be copied to /tmp/log and /tmp/log1 files
 
-#DESCRIPTION: This testscript creates a jffs2 file system type and tests the filesytem test
+#DESCRIPTION: This testscript creates a jffs2 file system type and tests the filesystem test
 #and places the log in the log directory.The file system test actually creates a tree of large
 #directories and performs the delete and random delete operations as per the filesystem stress
 #algorithim and gives a report of real time ,user time,system time taken to perform the file
diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index a3f90a3..4a2a37c 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -36,7 +36,7 @@ init()
 	if [ $? -ne 0 ]; then
 		iptables -L > tst_iptables.out 2>&1
 		if [ $? -ne 0 ]; then
-			tst_brkm TBROK "no iptables support in kenrel."
+			tst_brkm TBROK "no iptables support in kernel."
 		fi
 	fi
 
-- 
2.9.3


From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:57 +0200
Subject: [LTP] [COMMITTED] [PATCH 24/40] Make use of SAFE_MOUNT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-24-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/direct_io/dma_thread_diotest.c |  5 +----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  3 +--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  3 +--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  3 +--
 testcases/kernel/syscalls/acct/acct01.c            | 12 +++---------
 testcases/kernel/syscalls/chmod/chmod06.c          |  5 +----
 testcases/kernel/syscalls/chown/chown04.c          |  5 +----
 testcases/kernel/syscalls/fchmod/fchmod06.c        | 12 +++---------
 testcases/kernel/syscalls/fchown/fchown04.c        | 12 +++---------
 testcases/kernel/syscalls/lchown/lchown03.c        |  5 +----
 testcases/kernel/syscalls/link/link08.c            | 12 +++---------
 testcases/kernel/syscalls/linkat/linkat02.c        | 12 +++---------
 testcases/kernel/syscalls/mkdir/mkdir03.c          |  5 +----
 testcases/kernel/syscalls/mkdirat/mkdirat02.c      | 11 +++--------
 testcases/kernel/syscalls/mknod/mknod07.c          |  5 +----
 testcases/kernel/syscalls/mknodat/mknodat02.c      |  5 +----
 testcases/kernel/syscalls/mount/mount05.c          |  3 +--
 testcases/kernel/syscalls/mount/mount06.c          | 10 +++-------
 testcases/kernel/syscalls/rename/rename11.c        | 16 ++++------------
 testcases/kernel/syscalls/renameat/renameat01.c    | 12 +++---------
 testcases/kernel/syscalls/rmdir/rmdir02.c          | 12 +++---------
 testcases/kernel/syscalls/utime/utime06.c          |  5 +----
 testcases/kernel/syscalls/utimes/utimes01.c        | 12 +++---------
 23 files changed, 46 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index 5f52dcc9b..aa51bf2fb 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -401,10 +401,7 @@ static void setup(void)
 			tst_mkfs(NULL, device, "ext3", NULL, NULL);
 		}
 
-		if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "mount device:%s failed", device);
-		}
+		SAFE_MOUNT(NULL, device, MNT_POINT, "ext3", 0, NULL);
 		mount_flag = 1;
 	}
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index d56fbfaed..212a8529b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -96,8 +96,7 @@ void setup(void)
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
-	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
-		tst_brk(TBROK | TERRNO, "mount failed on %s", Hopt);
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 86142484d..52db226fe 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -142,8 +142,7 @@ static void setup(void)
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
-	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
-		tst_brk(TBROK | TERRNO, "mount failed on %s", Hopt);
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f6d51a5b6..2a368a390 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -113,8 +113,7 @@ void setup(void)
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
-	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
-		tst_brk(TBROK | TERRNO, "mount failed on %s", Hopt);
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 3137c05c1..eb104315b 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -152,20 +152,14 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, 0, NULL);
 	mount_flag = 1;
 
 	/* Create a file in the file system, then remount it as read-only */
 	fd = SAFE_CREAT(cleanup, TEST_FILE8, 0644);
 	SAFE_CLOSE(cleanup, fd);
-	if (mount(device, "mntpoint", fs_type,
-		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type,
+		   MS_REMOUNT | MS_RDONLY, NULL);
 }
 
 static void acct_verify(int i)
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 0cb060e27..acd653f7d 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -199,10 +199,7 @@ void setup(void)
 	/*
 	 * mount a read-only file system for test EROFS
 	 */
-	if (mount(device, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 
 	memset(long_path, 'a', PATH_MAX+1);
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 782706789..1f3ed412b 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -172,10 +172,7 @@ static void setup(void)
 	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
 
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	if (mount(device, "mntpoint", fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 619d54e3a..a5c6d911c 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -131,20 +131,14 @@ static void setup(void)
 
 	SAFE_MKDIR(cleanup, "mntpoint", 0755);
 
-	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, 0, NULL);
 	mount_flag = 1;
 
 	/* Create a file in the file system, then remount it as read-only */
 	SAFE_TOUCH(cleanup, "mntpoint/tfile_3", 0644, NULL);
 
-	if (mount(device, "mntpoint", fs_type,
-		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type,
+		   MS_REMOUNT | MS_RDONLY, NULL);
 
 	fd3 = SAFE_OPEN(cleanup, "mntpoint/tfile_3", O_RDONLY);
 
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index bae0796b4..12e332671 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -115,17 +115,11 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, 0, NULL);
 	mount_flag = 1;
 	SAFE_TOUCH(cleanup, "mntpoint/tfile_3", 0644, NULL);
-	if (mount(device, "mntpoint", fs_type,
-		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type,
+		   MS_REMOUNT | MS_RDONLY, NULL);
 	fd3 = SAFE_OPEN(cleanup, "mntpoint/tfile_3", O_RDONLY);
 
 	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
index 3f66a3885..c26f54c21 100644
--- a/testcases/kernel/syscalls/lchown/lchown03.c
+++ b/testcases/kernel/syscalls/lchown/lchown03.c
@@ -109,10 +109,7 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, TEST_EROFS, DIR_MODE);
-	if (mount(device, TEST_EROFS, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, TEST_EROFS, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 }
 
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index 05662e21d..8cb72d1df 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -145,18 +145,12 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	if (mount(device, MNT_POINT, fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, 0, NULL);
 	mount_flag = 1;
 
 	SAFE_TOUCH(cleanup, TEST_FILE2, 0644, NULL);
-	if (mount(device, MNT_POINT, fs_type,
-		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type,
+		   MS_REMOUNT | MS_RDONLY, NULL);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 292d9f57a..51785af02 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -173,10 +173,7 @@ static void setup(void)
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
 
-	if (mount(device, "mntpoint", fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, 0, NULL);
 	mount_flag = 1;
 
 	max_hardlinks = tst_fs_fill_hardlinks(cleanup, "emlink_dir");
@@ -194,11 +191,8 @@ static void cleanup_eacces(void)
 
 static void setup_erofs(void)
 {
-	if (mount(device, "mntpoint", fs_type,
-		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "remount device:%s failed",
-			 device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type,
+		   MS_REMOUNT | MS_RDONLY, NULL);
 	mount_flag = 1;
 }
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 5b43ab408..823ee9dd1 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -124,10 +124,7 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	if (mount(device, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 }
 
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index e4dd999b9..9dcf37fb1 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -119,17 +119,12 @@ static void setup(void)
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, "test_dir/mntpoint", DIR_MODE);
-	if (mount(device, "test_dir/mntpoint", fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "test_dir/mntpoint", fs_type, MS_RDONLY,
+		   NULL);
 	mount_flag_dir = 1;
 
 	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	if (mount(device, "mntpoint", fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, MS_RDONLY, NULL);
 	mount_flag_cur = 1;
 }
 
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index bdb664029..69cff02d9 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -129,10 +129,7 @@ static void setup(void)
 
 	/* mount a read-only file system for EROFS test */
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	if (mount(device, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 
 	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index 0216aa2f3..6c5054bbc 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -131,10 +131,7 @@ static void setup(void)
 	 * mount a read-only file system for EROFS test
 	 */
 	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	if (mount(device, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 	dir_fd = SAFE_OPEN(cleanup, MNT_POINT, O_DIRECTORY);
 
diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
index bd664fd39..ca26f9738 100644
--- a/testcases/kernel/syscalls/mount/mount05.c
+++ b/testcases/kernel/syscalls/mount/mount05.c
@@ -106,8 +106,7 @@ void setup(void)
 	if (dflag) {
 		tst_mkfs(NULL, device, fstype, NULL, NULL);
 
-		if (mount(device, mntpoint_src, fstype, 0, NULL) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "mount failed");
+		SAFE_MOUNT(cleanup, device, mntpoint_src, fstype, 0, NULL);
 	}
 
 	SAFE_FILE_PRINTF(cleanup, file_src, "TEST FILE");
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
index 143c9aff2..857f5f905 100644
--- a/testcases/kernel/syscalls/mount/mount06.c
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -69,9 +69,7 @@ int main(int argc, char *argv[])
 
 		tst_count = 0;
 
-		if (mount(device, mntpoint_src, fs_type, 0, NULL) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "mount %s failed",
-				 mntpoint_src);
+		SAFE_MOUNT(cleanup, device, mntpoint_src, fs_type, 0, NULL);
 
 		TEST(mount(mntpoint_src, mntpoint_des, fs_type, MS_MOVE, NULL));
 
@@ -138,13 +136,11 @@ static void setup(void)
 	 * Turn current dir into a private mount point being a parent
 	 * mount which is required by move mount.
 	 */
-	if (mount(path_name, path_name, "none", MS_BIND, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "bind mount failed");
+	SAFE_MOUNT(cleanup, path_name, path_name, "none", MS_BIND, NULL);
 
 	mount_flag = 1;
 
-	if (mount("none", path_name, "none", MS_PRIVATE, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mount private failed");
+	SAFE_MOUNT(cleanup, "none", path_name, "none", MS_PRIVATE, NULL);
 
 	snprintf(mntpoint_src, PATH_MAX, "%s/%s", path_name, MNTPOINT_SRC);
 	snprintf(mntpoint_des, PATH_MAX, "%s/%s", path_name, MNTPOINT_DES);
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 0c3e3b37c..17cf04c85 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -107,10 +107,7 @@ static void setup(void)
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
-	if (mount(device, MNTPOINT, fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
 	mount_flag = 1;
 	SAFE_TOUCH(cleanup, TEST_EROFS, 0644, NULL);
 
@@ -152,10 +149,8 @@ static void test_eloop(void)
 
 static void test_erofs(void)
 {
-	if (mount(device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
+		   NULL);
 
 	TEST(rename(TEST_EROFS, TEST_NEW_EROFS));
 	check_and_print(EROFS);
@@ -163,10 +158,7 @@ static void test_erofs(void)
 	if (TEST_RETURN == 0)
 		SAFE_UNLINK(cleanup, TEST_NEW_EROFS);
 
-	if (mount(device, MNTPOINT, fs_type, MS_REMOUNT, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "remount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT, NULL);
 }
 
 static void test_emlink(void)
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index f6797da31..817e21729 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -184,17 +184,11 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNTPOINT, DIRMODE);
-	if (mount(device, MNTPOINT, fs_type, 0, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
 	mount_flag = 1;
 	SAFE_TOUCH(cleanup, TESTFILE5, FILEMODE, NULL);
-	if (mount(device, MNTPOINT, fs_type,
-			MS_REMOUNT | MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
+		   NULL);
 
 	SAFE_MKDIR(cleanup, TESTDIR3, DIRMODE);
 	max_subdirs = tst_fs_fill_subdirs(cleanup, "testemlinkdir");
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 9e7581830..9f6954ad5 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -139,16 +139,10 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-	if (mount(device, MNTPOINT, fs_type, 0, NULL) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
 	SAFE_MKDIR(cleanup, TESTDIR5, DIR_MODE);
-	if (mount(device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
-			NULL) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
+		   NULL);
 	mount_flag = 1;
 
 	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 2a97cce3b..6d80677e4 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -122,10 +122,7 @@ static void setup(void)
 	tst_mkfs(cleanup, dev, fs_type, NULL, NULL);
 
 	SAFE_MKDIR(cleanup, MNT_POINT, 0644);
-	if (mount(dev, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", dev);
-	}
+	SAFE_MOUNT(cleanup, dev, MNT_POINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 
 	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index b2450d2b7..c79bd092c 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -141,20 +141,14 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-	if (mount(device, MNTPOINT, fs_type, 0, NULL) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
 	mount_flag = 1;
 	SAFE_TOUCH(cleanup, TESTFILE3, FILE_MODE, NULL);
 	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
 	SAFE_CHOWN(cleanup, TESTFILE3, ltpuser->pw_uid,
 		ltpuser->pw_gid);
-	if (mount(device, MNTPOINT, fs_type,
-			MS_REMOUNT | MS_RDONLY, NULL) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"mount device:%s failed", device);
-	}
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
+		   NULL);
 
 	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-- 
2.13.5


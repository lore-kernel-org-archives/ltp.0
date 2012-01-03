Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri0sB-0006ML-2G
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:41:35 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri0s9-00068F-Lc
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:41:35 +0000
Message-ID: <4F02CD36.2010600@imgtec.com>
Date: Tue, 3 Jan 2012 09:41:10 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010008020808030403070609"
Subject: [LTP] [PATCH 04/21] syscalls: Use %zu modifier to print variables
 of type size_t
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--------------010008020808030403070609
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------010008020808030403070609
Content-Type: text/plain;
	name="0004-syscalls-Use-zu-modifier-to-print-variables-of-type-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0004-syscalls-Use-zu-modifier-to-print-variables-of-type-.pa";
	filename*1="tch"

From 3b67685fd41d860daa874a52183b580c25a53dc3 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 14:36:13 +0000
Subject: [PATCH 04/21] syscalls: Use %zu modifier to print variables of type size_t

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/mem/mem/mem01.c                   |    8 ++++----
 testcases/kernel/syscalls/inotify/inotify01.c      |    4 ++--
 testcases/kernel/syscalls/inotify/inotify02.c      |    4 ++--
 testcases/kernel/syscalls/inotify/inotify03.c      |    8 ++++----
 testcases/kernel/syscalls/lseek/lseek08.c          |    4 ++--
 testcases/kernel/syscalls/mount/mount01.c          |    4 ++--
 testcases/kernel/syscalls/nftw/lib.c               |    4 ++--
 testcases/kernel/syscalls/nftw/lib64.c             |    4 ++--
 .../syscalls/remap_file_pages/remap_file_pages01.c |    8 ++++----
 .../syscalls/remap_file_pages/remap_file_pages02.c |    4 ++--
 testcases/kernel/syscalls/setgroups/compat_16.h    |    4 ++--
 testcases/kernel/syscalls/setgroups/setgroups03.c  |    4 ++--
 testcases/kernel/syscalls/symlinkat/symlinkat01.c  |    6 +++---
 testcases/kernel/syscalls/umount/umount01.c        |    6 +++---
 14 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/mem/mem/mem01.c b/testcases/kernel/mem/mem/mem01.c
index eb2921c..27905c3 100644
--- a/testcases/kernel/mem/mem/mem01.c
+++ b/testcases/kernel/mem/mem/mem01.c
@@ -299,7 +299,7 @@ main(int argc, char *argv[])
 	bigmalloc = p = (char*)malloc(memsize);
 
 	if (!p) {
-	    tst_resm(TFAIL, "malloc - alloc of %dMB failed", memsize/1024/1024);
+	    tst_resm(TFAIL, "malloc - alloc of %zuMB failed", memsize/1024/1024);
     	    cleanup();
 	}
 
@@ -308,7 +308,7 @@ main(int argc, char *argv[])
 	 * Dirty all the pages, to force physical RAM allocation
 	 * and exercise eventually the swapper
 	 */
-      tst_resm(TINFO,"touching %uMB of malloc'ed memory (%s)",
+      tst_resm(TINFO,"touching %zuMB of malloc'ed memory (%s)",
       			memsize/1024/1024, r_opt?"random":"linear");
 
 	loop_count = memsize/pagesize;
@@ -348,7 +348,7 @@ main(int argc, char *argv[])
        * seems that if the malloc'ed area was bad, we'd get SEGV (or kicked
        * somehow by the OOM killer?), hence we can indicate a PASS.
        */
-	tst_resm(TPASS, "malloc - alloc of %dMB succeeded", memsize/1024/1024);
+	tst_resm(TPASS, "malloc - alloc of %zuMB succeeded", memsize/1024/1024);
 
     }
 
@@ -358,4 +358,4 @@ main(int argc, char *argv[])
     cleanup();
 
   return 0;
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 6060125..4168c0e 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 		int len, i = 0, test_num = 0;
 		if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
 			tst_brkm(TBROK, cleanup,
-			    "read(%d, buf, %d) failed",
+			    "read(%d, buf, %zu) failed",
 			    fd_notify, EVENT_BUF_LEN);
 
 		}
@@ -301,4 +301,4 @@ int main(void)
 	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
 }
 
-#endif
\ No newline at end of file
+#endif
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 0ac98a9..4ffc00c 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -227,7 +227,7 @@ int main(int ac, char **av)
 		int len, i = 0, test_num = 0;
 		if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) == -1) {
 			tst_brkm(TBROK|TERRNO, cleanup,
-				 "read(%d, buf, %d) failed",
+				 "read(%d, buf, %zu) failed",
 				 fd_notify, EVENT_BUF_LEN);
 
 		}
@@ -360,4 +360,4 @@ int main(void)
 	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
 }
 
-#endif
\ No newline at end of file
+#endif
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index a9e6031..d3c3e7b 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -128,14 +128,14 @@ int main(int ac, char **av)
 	if (Tflag) {
 		Fstype = (char *)malloc(strlen(fstype) + 1);
 		if (Fstype == NULL) {
-			tst_brkm(TBROK, NULL, "malloc - failed to alloc %d"
+			tst_brkm(TBROK, NULL, "malloc - failed to alloc %zu"
 				 "errno %d", strlen(fstype), errno);
 		}
 		strncpy(Fstype, fstype, strlen(fstype) + 1);
 	} else {
 		Fstype = (char *)malloc(strlen(DEFAULT_FSTYPE) + 1);
 		if (Fstype == NULL) {
-			tst_brkm(TBROK, NULL, "malloc - failed to alloc %d"
+			tst_brkm(TBROK, NULL, "malloc - failed to alloc %zu"
 				 "errno %d", strlen(DEFAULT_FSTYPE), errno);
 		}
 		strncpy(Fstype, DEFAULT_FSTYPE, strlen(DEFAULT_FSTYPE) + 1);
@@ -172,7 +172,7 @@ int main(int ac, char **av)
 	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len < 0) {
 		tst_brkm(TBROK|TERRNO, cleanup,
-			 "read(%d, buf, %d) failed",
+			 "read(%d, buf, %zu) failed",
 			 fd_notify, EVENT_BUF_LEN);
 	}
 
@@ -340,4 +340,4 @@ int main()
 	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
 }
 
-#endif
\ No newline at end of file
+#endif
diff --git a/testcases/kernel/syscalls/lseek/lseek08.c b/testcases/kernel/syscalls/lseek/lseek08.c
index 51010fa..b49ee5c 100644
--- a/testcases/kernel/syscalls/lseek/lseek08.c
+++ b/testcases/kernel/syscalls/lseek/lseek08.c
@@ -128,7 +128,7 @@ int main(int ac, char **av)
 			 */
 			if (TEST_RETURN != file_size) {
 				tst_resm(TFAIL, "lseek() returned incorrect "
-					 "value %ld, expected %d",
+					 "value %ld, expected %zu",
 					 TEST_RETURN, file_size);
 				continue;
 			}
@@ -220,4 +220,4 @@ void cleanup()
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index 9e1b80c..751a8a9 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 	} else {
 		Fstype = malloc(strlen(DEFAULT_FSTYPE) + 1);
 		if (Fstype == NULL) {
-			tst_brkm(TBROK, NULL, "malloc - failed to alloc %d",
+			tst_brkm(TBROK, NULL, "malloc - failed to alloc %zu",
 			    strlen(DEFAULT_FSTYPE));
 		}
 		strncpy(Fstype, DEFAULT_FSTYPE, strlen(DEFAULT_FSTYPE) + 1);
@@ -222,4 +222,4 @@ void help()
 	printf("-T type	  : specifies the type of filesystem to be mounted."
 	       " Default ext2. \n");
 	printf("-D device : device used for mounting \n");
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/nftw/lib.c b/testcases/kernel/syscalls/nftw/lib.c
index dc6dc38..32f8db4 100644
--- a/testcases/kernel/syscalls/nftw/lib.c
+++ b/testcases/kernel/syscalls/nftw/lib.c
@@ -194,7 +194,7 @@ test_ENAMETOOLONG_path(char *name, int (*callback) (const char *), int expected)
 #endif
 
 	if ((path = (char *)malloc(pcPathMax + 2)) == NULL) {
-		tst_resm(TFAIL, "malloc(%i) for path failed: %s", pcPathMax + 2,
+		tst_resm(TFAIL, "malloc(%zu) for path failed: %s", pcPathMax + 2,
 			 strerror(errno));
 		cleanup_function();
 		fail_exit();
@@ -351,4 +351,4 @@ test_ENOENT_nofile(char *name, int (*callback) (const char *), int expected)
 		cleanup_function();
 		fail_exit();
 	}
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/nftw/lib64.c b/testcases/kernel/syscalls/nftw/lib64.c
index 45603ff..7e61f78 100644
--- a/testcases/kernel/syscalls/nftw/lib64.c
+++ b/testcases/kernel/syscalls/nftw/lib64.c
@@ -194,7 +194,7 @@ test_ENAMETOOLONG_path(char *name, int (*callback) (const char *), int expected)
 #endif
 
 	if ((path = (char *)malloc(pcPathMax + 2)) == NULL) {
-		tst_resm(TFAIL, "malloc(%i) for path failed: %s", pcPathMax + 2,
+		tst_resm(TFAIL, "malloc(%zu) for path failed: %s", pcPathMax + 2,
 			 strerror(errno));
 		cleanup_function();
 		fail_exit();
@@ -351,4 +351,4 @@ test_ENOENT_nofile(char *name, int (*callback) (const char *), int expected)
 		cleanup_function();
 		fail_exit();
 	}
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index 1f21199..01fd291 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -163,7 +163,7 @@ static void test_nonlinear(int fd)
 
 	if (write(fd, cache_contents, cache_sz) != cache_sz) {
 		tst_resm(TFAIL,
-			 "Write Error for \"cache_contents\" to \"cache_sz\" of %d (errno=%d : %s)",
+			 "Write Error for \"cache_contents\" to \"cache_sz\" of %zu (errno=%d : %s)",
 			 cache_sz, errno, strerror(errno));
 		cleanup(NULL);
 	}
@@ -185,7 +185,7 @@ static void test_nonlinear(int fd)
 		if (remap_file_pages(page, page_sz * 2, 0,
 				     (window_pages - i - 2), 0) == -1) {
 			tst_resm(TFAIL|TERRNO,
-				 "remap_file_pages error for page=%p, page_sz=%d, window_pages=%d",
+				 "remap_file_pages error for page=%p, page_sz=%zu, window_pages=%zu",
 				 page, (page_sz * 2), (window_pages - i - 2));
 			cleanup(data);
 		}
@@ -198,7 +198,7 @@ static void test_nonlinear(int fd)
 		if (i & 1) {
 			if (data[i * page_sz] != window_pages - i) {
 				tst_resm(TFAIL,
-					 "hm, mapped incorrect data, data[%d]=%d, (window_pages-%d)=%d",
+					 "hm, mapped incorrect data, data[%zu]=%d, (window_pages-%d)=%zu",
 					 (i * page_sz), data[i * page_sz], i,
 					 (window_pages - i));
 				cleanup(data);
@@ -206,7 +206,7 @@ static void test_nonlinear(int fd)
 		} else {
 			if (data[i * page_sz] != window_pages - i - 2) {
 				tst_resm(TFAIL,
-					 "hm, mapped incorrect data, data[%d]=%d, (window_pages-%d-2)=%d",
+					 "hm, mapped incorrect data, data[%zu]=%d, (window_pages-%d-2)=%zu",
 					 (i * page_sz), data[i * page_sz], i,
 					 (window_pages - i - 2));
 				cleanup(data);
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index fdcda3e..c30abe8 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -308,7 +308,7 @@ void setup()
 
 	if (write(fd, cache_contents, cache_sz) != cache_sz) {
 		tst_resm(TFAIL,
-			 "Write Error for \"cache_contents\" to \"cache_sz\" of %d (errno=%d : %s)",
+			 "Write Error for \"cache_contents\" to \"cache_sz\" of %zu (errno=%d : %s)",
 			 cache_sz, errno, strerror(errno));
 		cleanup();
 	}
@@ -347,4 +347,4 @@ void cleanup()
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/setgroups/compat_16.h b/testcases/kernel/syscalls/setgroups/compat_16.h
index 641a878..f3d1885 100644
--- a/testcases/kernel/syscalls/setgroups/compat_16.h
+++ b/testcases/kernel/syscalls/setgroups/compat_16.h
@@ -47,13 +47,13 @@ GETGROUPS(int size16, GID_T *list16)
 
 	list32 = malloc(size16 * sizeof(gid_t));
 	if (list32 == NULL)
-	  tst_brkm(TBROK, NULL, "malloc failed to alloc %d errno "
+	  tst_brkm(TBROK, NULL, "malloc failed to alloc %zu errno "
 		   " %d ", size16 * sizeof(gid_t), errno);
 
 	r = getgroups(size16, list32);
 	if (r < 0)
 	  goto out;
-  
+
 	for (i = 0; i < r; i++) {
 		if (!GID_SIZE_CHECK(list32[i]))
 		  tst_brkm(TBROK,
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index 2c0f1c1..a6180f5 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 
 	groups_list = malloc(ngroups_max * sizeof(GID_T));
 	if (groups_list == NULL) {
-		tst_brkm(TBROK, NULL, "malloc failed to alloc %d errno "
+		tst_brkm(TBROK, NULL, "malloc failed to alloc %zu errno "
 			 " %d ", ngroups_max * sizeof(GID_T), errno);
 	}
 
@@ -237,4 +237,4 @@ void cleanup()
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 4b4927e..9d916d6 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -212,12 +212,12 @@ static void mysymlinkat_test(struct test_struct* desc)
 				int len;
 				fd = SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed: %s", desc->referencefn1, O_RDWR);
 				if ((len=write(fd, &tnum, sizeof(tnum))) != sizeof(tnum))
-					tst_brkm(TBROK, cleanup, "write() failed: expected %d, returned %d; error: %s", sizeof(tnum), len, strerror(errno));
+					tst_brkm(TBROK, cleanup, "write() failed: expected %zu, returned %d; error: %s", sizeof(tnum), len, strerror(errno));
 				SUCCEED_OR_DIE(close, "close(%d) failed: %s", fd);
 
 				fd = SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed: %s", desc->referencefn2, O_RDONLY);
 				if ((len=read(fd, &vnum, sizeof(vnum))) != sizeof(tnum))
-					tst_brkm(TBROK, cleanup, "read() failed: expected %d, returned %d; error: %s", sizeof(vnum), len, strerror(errno));
+					tst_brkm(TBROK, cleanup, "read() failed: expected %zu, returned %d; error: %s", sizeof(vnum), len, strerror(errno));
 				SUCCEED_OR_DIE(close, "close(%d) failed: %s", fd);
 
 				if (tnum == vnum)
@@ -281,4 +281,4 @@ static void cleanup()
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 81113da..3e4497c 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -121,14 +121,14 @@ int main(int ac, char **av)
 	if (Tflag == 1) {
 		Fstype = strdup(fstype);
 		if (Fstype == NULL) {
-			tst_brkm(TBROK, NULL, "malloc - failed to alloc %d"
+			tst_brkm(TBROK, NULL, "malloc - failed to alloc %zu"
 				 "errno %d", strlen(fstype), errno);
 			tst_exit();
 		}
 	} else {
 		Fstype = strdup(DEFAULT_FSTYPE);
 		if (Fstype == NULL) {
-			tst_brkm(TBROK, NULL, "malloc - failed to alloc %d"
+			tst_brkm(TBROK, NULL, "malloc - failed to alloc %zu"
 				 "errno %d", strlen(DEFAULT_FSTYPE), errno);
 			tst_exit();
 		}
@@ -236,4 +236,4 @@ void help()
 	printf("-T type	  : specifies the type of filesystem to be mounted."
 	       " Default ext2. \n");
 	printf("-D device : device used for mounting \n");
-}
\ No newline at end of file
+}
-- 
1.7.1


--------------010008020808030403070609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------010008020808030403070609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010008020808030403070609--



Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <harsh@linux.vnet.ibm.com>) id 1PseH8-0005uj-1L
	for ltp-list@lists.sourceforge.net; Thu, 24 Feb 2011 16:42:46 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1PseH6-00017m-Jz
	for ltp-list@lists.sourceforge.net; Thu, 24 Feb 2011 16:42:45 +0000
From: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
Date: Thu, 24 Feb 2011 22:12:31 +0530
Message-Id: <1298565751-23539-1-git-send-email-harsh@linux.vnet.ibm.com>
Subject: [LTP] [PATCH v2] utime: Add exception for V9FS for utime functional
	test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net

The functional tests for utime checks if utime updates the
modification and access time to current time, however V9FS,
similar to NFS, by default uses the server's localtime if
client doesnt specify a new time. The current implentation
does not run the test if the underlying filesystem is NFS.
A similar check for V9FS is also required, hence this patch.

Signed-off-by: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
---
 include/test.h                            |    1 +
 lib/tst_is_cwd.c                          |   12 +++++++++++-
 testcases/kernel/syscalls/utime/utime01.c |    7 ++++++-
 testcases/kernel/syscalls/utime/utime02.c |    7 ++++++-
 testcases/kernel/syscalls/utime/utime03.c |    7 ++++++-
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/test.h b/include/test.h
index 019bc59..39bad72 100644
--- a/include/test.h
+++ b/include/test.h
@@ -214,6 +214,7 @@ int tst_kvercmp(int r1, int r2, int r3);
 
 /* lib/tst_is_cwd.c */
 int tst_is_cwd_nfs(void);
+int tst_is_cwd_v9fs(void);
 int tst_is_cwd_tmpfs(void);
 int tst_is_cwd_ramfs(void);
 
diff --git a/lib/tst_is_cwd.c b/lib/tst_is_cwd.c
index 775d1f3..8c169dd 100644
--- a/lib/tst_is_cwd.c
+++ b/lib/tst_is_cwd.c
@@ -31,6 +31,16 @@ int tst_is_cwd_nfs(void)
 	return sf.f_type == NFS_MAGIC ? 1 : 0;
 }
 
+#define V9FS_MAGIC 0x01021997 /* kernel-source/include/linux/magic.h */
+int tst_is_cwd_v9fs(void)
+{
+        struct statfs sf;
+        statfs(".", &sf);
+
+        /*  Verify that the file is not on a nfs filesystem */
+        return (sf.f_type == V9FS_MAGIC);
+}
+
 #define RAMFS_MAGIC 0x858458f6
 int tst_is_cwd_ramfs(void)
 {

diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index c917afa..a15440c 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -120,6 +120,11 @@ int main(int ac, char **av)
 			 "Cannot do utime on a file located on an NFS filesystem");
 	}
 
+        if (tst_is_cwd_v9fs()) {
+                tst_brkm(TCONF, cleanup,
+                         "Cannot do utime on a file located on an 9P filesystem");
+        }
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
 
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index 8928a78..f0558a8 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -125,6 +125,11 @@ int main(int ac, char **av)
 			 "Cannot do utime on a file located on an NFS filesystem");
 	}
 
+        if (tst_is_cwd_v9fs()) {
+                tst_brkm(TCONF, cleanup,
+                         "Cannot do utime on a file located on an 9P filesystem");
+        }
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 23402b7..4f70d2d 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -136,6 +136,11 @@ int main(int ac, char **av)
 			 "Cannot do utime on a file located on an NFS filesystem");
 	}
 
+        if (tst_is_cwd_v9fs()) {
+                tst_brkm(TCONF, cleanup,
+                         "Cannot do utime on a file located on an 9P filesystem");
+        }
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
-- 
1.7.1.1


------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

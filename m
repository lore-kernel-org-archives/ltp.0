Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XFmDP-0001s4-S9
	for ltp-list@lists.sourceforge.net; Fri, 08 Aug 2014 15:36:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XFmDN-0001JH-Ti
	for ltp-list@lists.sourceforge.net; Fri, 08 Aug 2014 15:36:23 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s78FaFWi011165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Aug 2014 11:36:15 -0400
Message-ID: <53E4EE6C.6090307@redhat.com>
Date: Fri, 08 Aug 2014 23:36:12 +0800
From: Zorro Lang <zlang@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fs/fsstress: prevent orphan and zombie processes to
	be left
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

    parent use signal handler to deal with SIGTERM, make sure
    children processes ended before parent.
---

when I run "killall fsstress" in my testcase, I can't use a simple
'wait' to wait fsstress
 all over then 'umount' device. Because many orphan processes still running.

This is not a bug, but I think this patch can make fsstress be better. So I
backport xfstests/fsstress here.

BTW, I modify some compile warning for opdesc_t ops[]. Hope it's not
wrong ;)

Thank you,
Zorro Lang


 testcases/kernel/fs/fsstress/fsstress.c | 78
++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c
b/testcases/kernel/fs/fsstress/fsstress.c
index 2243280..ec3f646 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -30,7 +30,11 @@
  * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
  */
 +#include <config.h>
 #include "global.h"
+#ifdef HAVE_SYS_PRCTL_H
+#include <sys/prctl.h>
+#endif
  #define XFS_ERRTAG_MAX		17
 @@ -160,35 +164,35 @@ opdesc_t ops[] = {
 	{OP_BULKSTAT, "bulkstat", bulkstat_f, 1, 0, 1},
 	{OP_BULKSTAT1, "bulkstat1", bulkstat1_f, 1, 0, 1},
 #endif
-	{OP_CHOWN, "chown", chown_f, 3, 1},
-	{OP_CREAT, "creat", creat_f, 4, 1},
-	{OP_DREAD, "dread", dread_f, 4, 0},
-	{OP_DWRITE, "dwrite", dwrite_f, 4, 1},
-	{OP_FDATASYNC, "fdatasync", fdatasync_f, 1, 1},
+	{OP_CHOWN, "chown", chown_f, 3, 1, 0},
+	{OP_CREAT, "creat", creat_f, 4, 1, 0},
+	{OP_DREAD, "dread", dread_f, 4, 0, 0},
+	{OP_DWRITE, "dwrite", dwrite_f, 4, 1, 0},
+	{OP_FDATASYNC, "fdatasync", fdatasync_f, 1, 1, 0},
 #ifndef NO_XFS
 	{OP_FREESP, "freesp", freesp_f, 1, 1, 1},
 #endif
-	{OP_FSYNC, "fsync", fsync_f, 1, 1},
-	{OP_GETDENTS, "getdents", getdents_f, 1, 0},
-	{OP_LINK, "link", link_f, 1, 1},
-	{OP_MKDIR, "mkdir", mkdir_f, 2, 1},
-	{OP_MKNOD, "mknod", mknod_f, 2, 1},
-	{OP_READ, "read", read_f, 1, 0},
-	{OP_READLINK, "readlink", readlink_f, 1, 0},
-	{OP_RENAME, "rename", rename_f, 2, 1},
+	{OP_FSYNC, "fsync", fsync_f, 1, 1, 0},
+	{OP_GETDENTS, "getdents", getdents_f, 1, 0, 0},
+	{OP_LINK, "link", link_f, 1, 1, 0},
+	{OP_MKDIR, "mkdir", mkdir_f, 2, 1, 0},
+	{OP_MKNOD, "mknod", mknod_f, 2, 1, 0},
+	{OP_READ, "read", read_f, 1, 0, 0},
+	{OP_READLINK, "readlink", readlink_f, 1, 0, 0},
+	{OP_RENAME, "rename", rename_f, 2, 1, 0},
 #ifndef NO_XFS
 	{OP_RESVSP, "resvsp", resvsp_f, 1, 1, 1},
 #endif
-	{OP_RMDIR, "rmdir", rmdir_f, 1, 1},
-	{OP_STAT, "stat", stat_f, 1, 0},
-	{OP_SYMLINK, "symlink", symlink_f, 2, 1},
-	{OP_SYNC, "sync", sync_f, 1, 0},
-	{OP_TRUNCATE, "truncate", truncate_f, 2, 1},
-	{OP_UNLINK, "unlink", unlink_f, 1, 1},
+	{OP_RMDIR, "rmdir", rmdir_f, 1, 1, 0},
+	{OP_STAT, "stat", stat_f, 1, 0, 0},
+	{OP_SYMLINK, "symlink", symlink_f, 2, 1, 0},
+	{OP_SYNC, "sync", sync_f, 1, 0, 0},
+	{OP_TRUNCATE, "truncate", truncate_f, 2, 1, 0},
+	{OP_UNLINK, "unlink", unlink_f, 1, 1, 0},
 #ifndef NO_XFS
 	{OP_UNRESVSP, "unresvsp", unresvsp_f, 1, 1, 1},
 #endif
-	{OP_WRITE, "write", write_f, 4, 1},
+	{OP_WRITE, "write", write_f, 4, 1, 0},
 }, *ops_end;
  flist_t flist[FT_nft] = {
@@ -227,6 +231,7 @@ int no_xfs = 0;
 #else
 int no_xfs = 1;
 #endif
+sig_atomic_t should_stop = 0;
  void add_to_flist(int, int, int);
 void append_pathname(pathname_t *, char *);
@@ -273,6 +278,11 @@ void usage(void);
 void write_freq(void);
 void zero_freq(void);
 +void sg_handler(int signum)
+{
+	should_stop = 1;
+}
+
 int main(int argc, char **argv)
 {
 	char buf[10];
@@ -297,6 +307,7 @@ int main(int argc, char **argv)
 #ifndef NO_XFS
 	xfs_error_injection_t err_inj;
 #endif
+	struct sigaction action;
  	errrange = errtag = 0;
 	umask(0);
@@ -465,17 +476,44 @@ int main(int argc, char **argv)
 #endif
 			close(fd);
 		unlink(buf);
+
+
 		if (nproc == 1) {
 			procid = 0;
 			doproc();
 		} else {
+			setpgid(0, 0);
+			action.sa_handler = sg_handler;
+			sigemptyset(&action.sa_mask);
+			action.sa_flags = 0;
+			if (sigaction(SIGTERM, &action, 0)) {
+				perror("sigaction failed");
+				exit(1);
+			}
+
 			for (i = 0; i < nproc; i++) {
 				if (fork() == 0) {
+
+					action.sa_handler = SIG_DFL;
+					sigemptyset(&action.sa_mask);
+					if (sigaction(SIGTERM, &action, 0))
+						return 1;
+#ifdef HAVE_SYS_PRCTL_H
+					prctl(PR_SET_PDEATHSIG, SIGKILL);
+					if (getppid() == 1) /* parent died already? */
+						return 0;
+#endif
 					procid = i;
 					doproc();
 					return 0;
 				}
 			}
+			while (wait(&stat) > 0 && !should_stop) {
+				continue;
+			}
+			action.sa_flags = SA_RESTART;
+			sigaction(SIGTERM, &action, 0);
+			kill(-getpid(), SIGTERM);
 			while (wait(&stat) > 0)
 				continue;
 		}
-- 
1.9.3


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

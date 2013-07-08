Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Uw3rz-0002Uu-Ac
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 05:20:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uw3rx-0005Ix-B5
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 05:20:15 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r685K2kt014552
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Jul 2013 13:20:03 +0800
Message-ID: <51DA4BB8.9070703@cn.fujitsu.com>
Date: Mon, 08 Jul 2013 13:18:48 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51DA4B63.9010700@cn.fujitsu.com>
In-Reply-To: <51DA4B63.9010700@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2 v2] mount/mount03.c: Test feature MS_NOATIME of
 mount(2)
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
To: LTP list <ltp-list@lists.sourceforge.net>


Additional test for feature MS_NOATIME.

---
 testcases/kernel/syscalls/mount/mount03.c | 51 ++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index a4c065a..d3f0733 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -27,6 +27,7 @@
  *	4) MS_SYNCHRONOUS - writes are synced at once.
  *	5) MS_REMOUNT - alter flags of a mounted FS.
  *	6) MS_NOSUID - ignore suid and sgid bits.
+ *	7) MS_NOATIME - do not update access times.
  */

 #ifndef _GNU_SOURCE
@@ -53,7 +54,7 @@ static void cleanup(void);
 static int test_rwflag(int, int);

 char *TCID = "mount03";
-int TST_TOTAL = 6;
+int TST_TOTAL = 7;

 #define DEFAULT_FSTYPE	"ext2"
 #define TEMP_FILE	"temp_file"
@@ -83,6 +84,7 @@ long rwflags[] = {
 	MS_SYNCHRONOUS,
 	MS_RDONLY,
 	MS_NOSUID,
+	MS_NOATIME,
 };

 static option_t options[] = {
@@ -161,8 +163,9 @@ int test_rwflag(int i, int cnt)
 {
 	int ret, fd, pid, status;
 	char nobody_uid[] = "nobody";
+	time_t atime;
 	struct passwd *ltpuser;
-	struct stat setuid_test_stat;
+	struct stat file_stat;

 	switch (i) {
 	case 0:
@@ -294,10 +297,10 @@ int test_rwflag(int i, int cnt)
 		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
 		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");

-		if (stat(file, &setuid_test_stat) < 0)
+		if (stat(file, &file_stat) < 0)
 			tst_brkm(TBROK, cleanup, "stat for setuid_test failed");

-		if (setuid_test_stat.st_mode != SUID_MODE &&
+		if (file_stat.st_mode != SUID_MODE &&
 		    chmod(file, SUID_MODE) < 0)
 			tst_brkm(TBROK, cleanup,
 				 "setuid for setuid_test failed");
@@ -326,6 +329,46 @@ int test_rwflag(int i, int cnt)
 					return 1;
 			}
 		}
+	case 6:
+		/* Validate MS_NOATIME flag of mount call */
+
+		snprintf(file, PATH_MAX, "%satime", path_name);
+		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
+		if (fd == -1) {
+			tst_resm(TWARN | TERRNO, "opening %s failed", file);
+			return 1;
+		}
+
+		if (write(fd, "TEST_MS_NOATIME", 15) != 15) {
+			tst_resm(TWARN | TERRNO, "write %s failed", file);
+			return 1;
+		}
+
+		if (fstat(fd, &file_stat) == -1) {
+			tst_resm(TWARN | TERRNO, "stat %s failed #1", file);
+			return 1;
+		}
+
+		atime = file_stat.st_atime;
+
+		sleep(1);
+
+		if (read(fd, NULL, 20) == -1) {
+			tst_resm(TWARN | TERRNO, "read %s failed", file);
+			return 1;
+		}
+
+		if (fstat(fd, &file_stat) == -1) {
+			tst_resm(TWARN | TERRNO, "stat %s failed #2", file);
+			return 1;
+		}
+		close(fd);
+
+		if (file_stat.st_atime != atime) {
+			tst_resm(TWARN, "access time is updated");
+			return 1;
+		}
+		return 0;
 	}
 	return 0;
 }
-- 
1.8.1



------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

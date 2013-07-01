Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Utbpd-0004ZJ-QN
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 10:59:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Utbpb-0005a3-UH
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 10:59:41 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r61AxWh2017450
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Jul 2013 18:59:32 +0800
Message-ID: <51D160D2.4070806@cn.fujitsu.com>
Date: Mon, 01 Jul 2013 18:58:26 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mount/mount03.c: Test feature MS_NOATIME of mount(2)
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


Additional test for features MS_NOATIME.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 47 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index b1aa71f..370b880 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -20,7 +20,7 @@
  *
  *    TEST TITLE	: Test for checking mount(2) flags
  *
- *    TEST CASE TOTAL	: 6
+ *    TEST CASE TOTAL	: 7
  *
  *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  *
@@ -35,6 +35,7 @@
  *	4) MS_SYNCHRONOUS - writes are synced at once.
  *	5) MS_REMOUNT - alter flags of a mounted FS.
  *	6) MS_NOSUID - ignore suid and sgid bits.
+ *	7) MS_NOATIME - do not update access times.
  *
  *	Setup:
  *	  Setup signal handling.
@@ -83,7 +84,7 @@ static int test_rwflag(int, int);
 static int setup_uid(void);

 char *TCID = "mount03";
-int TST_TOTAL = 6;
+int TST_TOTAL = 7;

 #define DEFAULT_FSTYPE	"ext2"
 #define TEMP_FILE	"temp_file"
@@ -115,6 +116,7 @@ long rwflags[] = {
 	MS_SYNCHRONOUS,
 	MS_RDONLY,
 	MS_NOSUID,
+	MS_NOATIME,
 };

 static option_t options[] = {
@@ -208,6 +210,8 @@ int test_rwflag(int i, int cnt)
 {
 	int ret, fd, pid, status;
 	char nobody_uid[] = "nobody";
+	time_t atime;
+	struct stat file_stat;
 	struct passwd *ltpuser;

 	switch (i) {
@@ -370,6 +374,45 @@ int test_rwflag(int i, int cnt)
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
+		if (read(fd, NULL, 20) == -1) {
+			tst_resm(TWARN | TERRNO, "read %s failed", file);
+			return 1;
+		}
+
+		if (fstat(fd, &file_stat) == -1) {
+			tst_resm(TWARN | TERRNO, "stat %s failed #2", file);
+			return 1;
+		}
+
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

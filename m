Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Uc5TL-0008Tn-M6
	for ltp-list@lists.sourceforge.net; Tue, 14 May 2013 03:00:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uc5TJ-0003Yd-PS
	for ltp-list@lists.sourceforge.net; Tue, 14 May 2013 03:00:15 +0000
Message-ID: <5191A41C.1080808@cn.fujitsu.com>
Date: Tue, 14 May 2013 10:40:28 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <5191A1F3.3040407@cn.fujitsu.com>
In-Reply-To: <5191A1F3.3040407@cn.fujitsu.com>
Subject: [LTP]  [PATCH V2 2/2] mount/mount03.c: fix several issues
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

Make following fixes:
* Create the file before calling stat(file).
  Call get_current_dir_name() after tst_tmpdir().
  Fix incorrect using of snprintf().

* For MS_NOEXEC test, change judgement method to
  If errno is set to EACCES after execlp(exec-file), this case passes.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index eea2de7..295b6da 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -206,7 +206,7 @@ int main(int argc, char *argv[])

 int test_rwflag(int i, int cnt)
 {
-	int fd, pid, status;
+	int ret, fd, pid, status;
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;

@@ -259,7 +259,9 @@ int test_rwflag(int i, int cnt)
 			tst_resm(TWARN | TERRNO, "opening %s failed", file);
 		} else {
 			close(fd);
-			execlp(file, basename(file), NULL);
+			ret = execlp(file, basename(file), NULL);
+			if ((ret == -1) && (errno == EACCES))
+				return 0;
 		}
 		return 1;
 	case 3:
@@ -410,6 +412,8 @@ int setup_uid()

 void setup()
 {
+	int fd;
+	char path[PATH_MAX];
 	char *test_home;
 	struct stat setuid_test_stat;

@@ -421,10 +425,10 @@ void setup()
 		tst_brkm(TBROK, NULL, "Test must be run as root");
 	}

-	test_home = get_current_dir_name();
-
 	tst_tmpdir();

+	test_home = get_current_dir_name();
+
 	sprintf(mntpoint, "mnt_%d", getpid());

 	if (mkdir(mntpoint, DIR_MODE))
@@ -439,7 +443,12 @@ void setup()
 		tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
 			 path_name, DIR_MODE);

-	snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
+	snprintf(file, PATH_MAX, "%s/setuid_test", path_name);
+	fd = open(file, O_CREAT | O_TRUNC);
+	if (fd == -1)
+		tst_brkm(TBROK, cleanup, "open file failed");
+	close(fd);
+
 	if (stat(file, &setuid_test_stat) < 0) {
 		tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
 	} else {
@@ -457,8 +466,8 @@ void setup()
 	/*
 	 * under temporary directory
 	 */
-	snprintf(path_name, PATH_MAX, "%s/%s/", path_name, mntpoint);
-
+	strncpy(path, path_name, PATH_MAX);
+	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
 	strcpy(testhome_path, test_home);
 	strcat(testhome_path, "/setuid_test");

-- 
1.8.1

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

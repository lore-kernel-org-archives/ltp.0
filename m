Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <monstr@monstr.eu>) id 1R4ADW-0006qf-Pm
	for ltp-list@lists.sourceforge.net; Thu, 15 Sep 2011 11:34:54 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R4ADV-00038x-DB
	for ltp-list@lists.sourceforge.net; Thu, 15 Sep 2011 11:34:54 +0000
Received: by bke11 with SMTP id 11so3285241bke.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Sep 2011 04:34:46 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 15 Sep 2011 13:09:02 +0200
Message-Id: <1316084942-24319-1-git-send-email-monstr@monstr.eu>
Subject: [LTP] [PATCH] creat08: Fix test to be able to run on NFS
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
To: ltp-list@lists.sourceforge.net
Cc: Michal Simek <monstr@monstr.eu>

NFS creates temporary .nfsXXX files for every open/created file.
Based on this rmdir syscall failed because directory is not empty.
The solution is to close all open/created files. They are also unlink
in cleanup.

Error log:
creat08     5  TBROK  :  rmdir testdir.A.167 failed: errno=???(39): Directory not empty
creat08     6  TBROK  :  Remaining cases broken

Example of created files(listed by readdir):
testdir.A.155
.nfs00000000070201f60000007d
..
.nfs00000000070201f70000007c
.

testdir.B.155
.nfs00000000000dc13c0000007f
.nfs00000000000dc1050000007e
..
.
.nfs00000000000dc0f600000080

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 testcases/kernel/syscalls/creat/creat08.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index ec2fcf1..30b451a 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -86,6 +86,7 @@ int main(int ac, char **av)
 	uid_t save_myuid, user1_uid;
 	pid_t mypid;
 
+	int fd;
 	int lc;			/* loop counter */
 	char *msg;		/* message returned from parse_opts */
 
@@ -240,7 +241,8 @@ int main(int ac, char **av)
 		/*
 		 * Create the file with setgid not set
 		 */
-		if (open(nosetgid_A, O_CREAT|O_EXCL|O_RDWR, MODE_RWX) == -1) {
+		fd = open(nosetgid_A, O_CREAT|O_EXCL|O_RDWR, MODE_RWX);
+		if (fd == -1) {
 			tst_resm(TFAIL, "Creation of %s failed", nosetgid_A);
 			local_flag = FAILED;
 		}
@@ -262,12 +264,13 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "%s: Incorrect group", nosetgid_A);
 			local_flag = FAILED;
 		}
+		close(fd);
 
 		/*
 		 * Create the file with setgid set
 		 */
-		if (open(setgid_A, O_CREAT | O_EXCL | O_RDWR, MODE_SGID) ==
-		    -1) {
+		fd = open(setgid_A, O_CREAT | O_EXCL | O_RDWR, MODE_SGID);
+		if (fd == -1) {
 			tst_resm(TFAIL, "Creation of %s failed", setgid_A);
 			local_flag = FAILED;
 		}
@@ -291,6 +294,8 @@ int main(int ac, char **av)
 			tst_resm(TINFO, "got %u and %u", buf.st_gid, mygid);
 			local_flag = FAILED;
 		}
+		close(fd);
+
 		if (local_flag == PASSED) {
 			tst_resm(TPASS, "Test passed in block1.");
 		} else {
@@ -308,7 +313,8 @@ int main(int ac, char **av)
 		/*
 		 * Create the file with setgid not set
 		 */
-		if (creat(nosetgid_B, MODE_RWX) == -1) {
+		fd = creat(nosetgid_B, MODE_RWX);
+		if (fd == -1) {
 			tst_resm(TFAIL, "Creation of %s failed", nosetgid_B);
 			local_flag = FAILED;
 		}
@@ -331,11 +337,13 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "%s: Incorrect group", nosetgid_B);
 			local_flag = FAILED;
 		}
+		close(fd);
 
 		/*
 		 * Create the file with setgid set
 		 */
-		if (creat(setgid_B, MODE_SGID) == -1) {
+		fd = creat(setgid_B, MODE_SGID);
+		if (fd == -1) {
 			tst_resm(TFAIL, "Creation of %s failed", setgid_B);
 			local_flag = FAILED;
 		}
@@ -360,6 +368,7 @@ int main(int ac, char **av)
 				 setgid_B);
 			local_flag = FAILED;
 		}
+		close(fd);
 
 		if (local_flag == PASSED) {
 			tst_resm(TPASS, "Test passed in block2.");
@@ -381,7 +390,8 @@ int main(int ac, char **av)
 		}
 
 		/* Create the file with setgid set */
-		if (creat(root_setgid_B, MODE_SGID) == -1) {
+		fd = creat(root_setgid_B, MODE_SGID);
+		if (fd == -1) {
 			tst_resm(TFAIL, "Creation of %s failed", root_setgid_B);
 			local_flag = FAILED;
 		}
@@ -406,6 +416,7 @@ int main(int ac, char **av)
 				 group2_gid);
 			local_flag = FAILED;
 		}
+		close(fd);
 
 		if (local_flag == PASSED) {
 			tst_resm(TPASS, "Test passed in block3");
-- 
1.5.5.6


------------------------------------------------------------------------------
Doing More with Less: The Next Generation Virtual Desktop 
What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

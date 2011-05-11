Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QK5u4-0000Uq-F5
	for ltp-list@lists.sourceforge.net; Wed, 11 May 2011 09:40:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QK5u3-0003Vn-LV
	for ltp-list@lists.sourceforge.net; Wed, 11 May 2011 09:40:24 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4B9eHCO007250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 May 2011 05:40:17 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Wed, 11 May 2011 17:39:54 +0800
Message-Id: <1aca96688a199f0cc6559a3f64be2ca1d73e6842.1305106654.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [syscalls] chown03: fix EPERM issue
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


in setup phase of chown03 testcase, it set effective gid/uid before
create tmpdir, this might cause EPERM error under some circumstance:

chown03     1  TBROK  :  chown(/tmp/ltp-1FYYTiULQl/chos2UBh3, -1, 0) failed: errno=EPERM(1): Operation not permitted
chown03     2  TBROK  :  Remaining cases broken
chown03     0  TWARN  :  tst_brk: Invalid Type: 4. Using TBROK
chown03     3  TBROK  :  tmpdir_cleanup: no user cleanup function called before exiting

This patch creates tmpdir first, then set the effective gid/uid to test.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/chown/chown03.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-syscalls-chown03-fix-EPERM-issue.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-chown03-fix-EPERM-issue.patch"

diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index 34b2d59..e26be0d 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -167,6 +167,10 @@ void setup()
 
 	tst_require_root(NULL);
 
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
 	ltpuser = getpwnam(nobody_uid);
 	if (ltpuser == NULL)
 		tst_brkm(TBROK|TERRNO, NULL, "getpwnam(\"nobody\") failed");
@@ -177,10 +181,6 @@ void setup()
 		tst_brkm(TBROK|TERRNO, NULL, "seteuid(%d) failed",
 		    ltpuser->pw_uid);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
 	/* Create a test file under temporary directory */
 	if ((fd = open(TESTFILE, O_RDWR|O_CREAT, FILE_MODE)) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup,
@@ -213,4 +213,4 @@ void cleanup()
 
 	tst_rmdir();
 
-}
\ No newline at end of file
+}

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--




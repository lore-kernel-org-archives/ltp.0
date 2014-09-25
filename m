Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XX3Pf-00040O-Jy
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 07:24:27 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XX3Pd-00046i-TE
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 07:24:27 +0000
Date: Thu, 25 Sep 2014 03:24:19 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <385992509.36875157.1411629859497.JavaMail.zimbra@redhat.com>
In-Reply-To: <1793864039.34479334.1411109349130.JavaMail.zimbra@redhat.com>
References: <661064059.31210197.1410431541563.JavaMail.zimbra@redhat.com>
	<5411B637.2020104@oracle.com>
	<1793864039.34479334.1411109349130.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 3/3] splice01/tee01/utime: add kernel version check
 for NFS test
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, ltp-list@lists.sourceforge.net


Tests splice01 tee01 pass on NFS since 2.6.32 at least,
and utime01/02/03 pass since 2.6.18 at least.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/splice/splice01.c | 5 +++--
 testcases/kernel/syscalls/tee/tee01.c       | 5 +++--
 testcases/kernel/syscalls/utime/utime01.c   | 7 ++++++-
 testcases/kernel/syscalls/utime/utime02.c   | 7 ++++++-
 testcases/kernel/syscalls/utime/utime03.c   | 7 ++++++-
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index e96ff6d..8896638 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -135,8 +135,9 @@ static void setup(void)
 	tst_tmpdir();
 
 	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do splice on a file on NFS filesystem");
+		if  (tst_kvercmp(2, 6, 32) < 0)
+			tst_brkm(TCONF, cleanup, "Cannot do splice on a file"
+				" on NFS filesystem before 2.6.32");
 	}
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++)
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 6ea6f18..3ba0804 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -147,8 +147,9 @@ static void setup(void)
 	tst_tmpdir();
 
 	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do tee on a file on NFS filesystem");
+		if ((tst_kvercmp(2, 6, 32)) < 0)
+			tst_brkm(TCONF, cleanup, "Cannot do tee on a file"
+				" on NFS filesystem before 2.6.32");
 	}
 
 	for (i = 0; i < TEST_BLOCK_SIZE; i++)
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 3128965..0e0165d 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -115,11 +115,16 @@ int main(int ac, char **av)
 
 	switch ((type = tst_fs_type(cleanup, "."))) {
 	case TST_NFS_MAGIC:
+		if (tst_kvercmp(2, 6, 18) < 0)
+			tst_brkm(TCONF, cleanup, "Cannot do utime on a file"
+				" on %s filesystem before 2.6.18",
+				 tst_fs_type_name(type));
+		break;
 	case TST_V9FS_MAGIC:
 		tst_brkm(TCONF, cleanup,
 			 "Cannot do utime on a file on %s filesystem",
 			 tst_fs_type_name(type));
-	break;
+		break;
 	}
 
 	/* set the expected errnos... */
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index cbd30da..aeaf6d6 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -121,11 +121,16 @@ int main(int ac, char **av)
 
 	switch ((type = tst_fs_type(cleanup, "."))) {
 	case TST_NFS_MAGIC:
+		if (tst_kvercmp(2, 6, 18) < 0)
+			tst_brkm(TCONF, cleanup, "Cannot do utime on a file"
+				" on %s filesystem before 2.6.18",
+				 tst_fs_type_name(type));
+		break;
 	case TST_V9FS_MAGIC:
 		tst_brkm(TCONF, cleanup,
 			 "Cannot do utime on a file on %s filesystem",
 			 tst_fs_type_name(type));
-	break;
+		break;
 	}
 
 	/* set the expected errnos... */
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 858f6ca..da1bf78 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -131,11 +131,16 @@ int main(int ac, char **av)
 
 	switch ((type = tst_fs_type(cleanup, "."))) {
 	case TST_NFS_MAGIC:
+		if (tst_kvercmp(2, 6, 18) < 0)
+			tst_brkm(TCONF, cleanup, "Cannot do utime on a file"
+				" on %s filesystem before 2.6.18",
+				 tst_fs_type_name(type));
+		break;
 	case TST_V9FS_MAGIC:
 		tst_brkm(TCONF, cleanup,
 			 "Cannot do utime on a file on %s filesystem",
 			 tst_fs_type_name(type));
-	break;
+		break;
 	}
 
 	/* set the expected errnos... */
-- 
1.8.3.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

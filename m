Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QJpGN-0006ae-FM
	for ltp-list@lists.sourceforge.net; Tue, 10 May 2011 15:54:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QJpGJ-0006gE-50
	for ltp-list@lists.sourceforge.net; Tue, 10 May 2011 15:54:19 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4AFs93r026549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 10 May 2011 11:54:09 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Tue, 10 May 2011 23:53:46 +0800
Message-Id: <40b09ff7d8ded0fdbb3719b95e910d1faec0d319.1305042807.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] ksm02,04: fix typo
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


Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/ksm/ksm02.c |    2 +-
 testcases/kernel/mem/ksm/ksm04.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-ksm02-04-fix-typo.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-ksm02-04-fix-typo.patch"

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 39ad3f9..01cadb4 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -106,7 +106,7 @@ int main(int argc, char *argv[])
 			if (errno != ENOSYS)
 				tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
 			else
-				tst_resm(TCONF, cleanup,
+				tst_brkm(TCONF, cleanup,
 					"set_mempolicy syscall is not implemented on your system.");
 		}
 		create_same_memory(size, num, unit);
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 85ebb99..791d621 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -108,7 +108,7 @@ int main(int argc, char *argv[])
 			if (errno != ENOSYS)
 				tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
 			else
-				tst_resm(TCONF, cleanup,
+				tst_brkm(TCONF, cleanup,
 					"set_mempolicy syscall is not implemented on your system.");
 		}
 		create_same_memory(size, num, unit);

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




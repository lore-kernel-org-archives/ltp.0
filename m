Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PORoR-0001WM-S7
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 09:20:19 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PORoQ-0001j1-EO
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 09:20:19 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB39KCEO009504
	for <ltp-list@lists.sourceforge.net>; Fri, 3 Dec 2010 04:20:12 -0500
Date: Fri, 3 Dec 2010 04:20:12 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <962261344.1177181291368012588.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <574510881.1177151291368009600.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_65576_877220057.1291368012587"
Subject: [LTP] [PATCH] ksm01: fix a typo.
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_65576_877220057.1291368012587
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This should be applied after,
http://marc.info/?l=ltp-list&m=129111266431874&w=2

---
 testcases/kernel/mem/ksm/ksm01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 24299ae..ed8201c 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -493,7 +493,7 @@ int ksmtest(void)
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
 		if (WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child exit status is %d",
-				WEXITSTATUS(n));
+				WEXITSTATUS(status));
 	}
 	return 0;
 }
-- 
1.7.1
------=_Part_65576_877220057.1291368012587
Content-Type: text/x-patch; name=0001-ksm01-fix-a-typo.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0001-ksm01-fix-a-typo.patch

From 6b9b1c42430a255e7f52e3cd986c516bef7300db Mon Sep 17 00:00:00 2001
From: CAI Qian <caiqian@redhat.com>
Date: Fri, 3 Dec 2010 17:01:33 +0800
Subject: [PATCH] ksm01: fix a typo.

---
 testcases/kernel/mem/ksm/ksm01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 24299ae..ed8201c 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -493,7 +493,7 @@ int ksmtest(void)
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
 		if (WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child exit status is %d",
-				WEXITSTATUS(n));
+				WEXITSTATUS(status));
 	}
 	return 0;
 }
-- 
1.7.1


------=_Part_65576_877220057.1291368012587
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_65576_877220057.1291368012587
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_65576_877220057.1291368012587--


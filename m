Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q9WGK-0003RT-2K
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 05:35:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9WGJ-00028r-50
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 05:35:40 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3C5ZXVQ002956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Apr 2011 01:35:33 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Tue, 12 Apr 2011 13:35:23 +0800
Message-Id: <cd5131a04961c81e7a09a88c2d6c3020429d451a.1302586505.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [hugetlb] hugeshmctl01: should exit when shmat fails
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


if shmat() fails in hugeshmctl01 test, the test should exit, else -1
will return, which may cause SIGSEGV due to this line:

*(int *)test = i;

thus incorrect signal sent to parent and test gets blocked infiniately.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-hugetlb-hugeshmctl01-should-exit-when-shmat-fails.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-hugetlb-hugeshmctl01-should-exit-when-shmat-fails.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 48740cd..1fd5dec 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -213,14 +213,8 @@ set_shmat()
 	/* attach the shared memory */
 	rval = shmat(shm_id_1, 0, 0);
 
-	/*
-	 * if shmat() fails, the only thing we can do is
-	 * print a message to that effect.
-	 */
-	if (rval == (void *)-1) {
-		tst_resm(TBROK, "shmat() failed - %s",strerror(errno));
-		cleanup();
-	}
+	if (rval == (void *)-1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmat() failed.")
 
 	return rval;
 }

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
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




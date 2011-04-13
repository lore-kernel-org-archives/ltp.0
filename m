Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q9y0O-0006Jd-5Y
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 11:13:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9y0I-0002ND-LJ
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 11:13:04 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3DBCqFH013744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Apr 2011 07:12:52 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Wed, 13 Apr 2011 19:12:40 +0800
Message-Id: <13c00d6b60ba3b56e0d774ecc06c701417f3a288.1302693113.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [mm] cpuset01: stop testing if no numa
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


Since NUMA is only supported by a few types of machines on x86, if no
NUMA support, the numa_count will return 0, this is also acceptable and
should stop the test without give an error.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-mm-cpuset01-stop-testing-if-no-numa.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-cpuset01-stop-testing-if-no-numa.patch"

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 10ccde7..4354db8 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -179,7 +179,7 @@ void setup(void)
 {
 	tst_require_root(NULL);
 
-	if (count_numa() == 1)
+	if (count_numa() <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;

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




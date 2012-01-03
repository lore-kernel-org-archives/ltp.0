Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4KU-0008C6-Ct
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:23:02 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4KT-0003T3-C1
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:23:02 +0000
Message-ID: <4F03012E.40901@imgtec.com>
Date: Tue, 3 Jan 2012 13:22:54 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050706040508020709010801"
Subject: [LTP] [PATCH 17/21] network/lib6/asapi_04: Cast pointer arithmetic
 to proper integer
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
To: ltp-list@lists.sourceforge.net

--------------050706040508020709010801
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------050706040508020709010801
Content-Type: text/plain;
	name="0017-network-lib6-asapi_04-Cast-pointer-arithmetic-to-pro.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0017-network-lib6-asapi_04-Cast-pointer-arithmetic-to-pro.pa";
	filename*1="tch"

From a80f7d1ab66cb2385a67ad1860f4860be6955a6d Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 15:08:39 +0000
Subject: [PATCH 17/21] network/lib6/asapi_04: Cast pointer arithmetic to proper integer

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/network/lib6/asapi_04.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/lib6/asapi_04.c b/testcases/network/lib6/asapi_04.c
index 9f7efbd..9c6ad3b 100644
--- a/testcases/network/lib6/asapi_04.c
+++ b/testcases/network/lib6/asapi_04.c
@@ -337,7 +337,7 @@ static int client(int prot, int sfd)
 			if (*p != 0xa5) {
 				tst_resm(TFAIL, "IPV6_CHECKSUM corrupt data "
 					"0x%02x != 0xa5 at offset %d in packet",
-					*p, p - rpbuf);
+					*p, (int)(p - rpbuf));
 				rv = 0;
 				break;
 			}
@@ -532,4 +532,4 @@ cleanup(void)
 	TEST_CLEANUP;
 }
 
-int TST_TOTAL = PTCOUNT + CSCOUNT;
\ No newline at end of file
+int TST_TOTAL = PTCOUNT + CSCOUNT;
-- 
1.7.1


--------------050706040508020709010801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------050706040508020709010801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050706040508020709010801--



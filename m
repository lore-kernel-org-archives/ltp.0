Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4LC-0007Iy-PN
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:23:46 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4LC-0001Ff-3W
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:23:46 +0000
Message-ID: <4F03015B.5050700@imgtec.com>
Date: Tue, 3 Jan 2012 13:23:39 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050006050200090409070702"
Subject: [LTP] [PATCH 18/21] network/lib6/asapi_06: pcmsg->cmsg_len is of
	type size_t
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

--------------050006050200090409070702
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------050006050200090409070702
Content-Type: text/plain;
	name="0018-network-lib6-asapi_06-pcmsg-cmsg_len-is-of-type-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0018-network-lib6-asapi_06-pcmsg-cmsg_len-is-of-type-size.pa";
	filename*1="tch"

From a83368f2077913705a54532b48b1bd3634cc9934 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 15:10:11 +0000
Subject: [PATCH 18/21] network/lib6/asapi_06: pcmsg->cmsg_len is of type size_t

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/network/lib6/asapi_06.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/lib6/asapi_06.c b/testcases/network/lib6/asapi_06.c
index 3808c37..6f4428b 100644
--- a/testcases/network/lib6/asapi_06.c
+++ b/testcases/network/lib6/asapi_06.c
@@ -413,7 +413,7 @@ so_test(struct soent *psoe)
 				break;
 			else if (psoe->so_clear) {
 				tst_resm(TFAIL, "%s receive: extraneous data "
-					"in control: level %d type %d len %d",
+					"in control: level %d type %d len %zu",
 					psoe->so_tname, pcmsg->cmsg_level,
 					pcmsg->cmsg_type, pcmsg->cmsg_len);
 				return;
@@ -643,4 +643,4 @@ cleanup(void)
 {
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
-- 
1.7.1


--------------050006050200090409070702
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
--------------050006050200090409070702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050006050200090409070702--



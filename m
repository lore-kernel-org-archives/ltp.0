Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Vr2MZ-0004kW-BB
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 09:15:19 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vr2MY-0003jP-7k
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 09:15:19 +0000
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 12 Dec 2013 09:14:46 +0000
Message-ID: <1386839686-7711-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] utils: sctp: Fix build for prefixed architectures
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
To: ltp-list@lists.sourceforge.net

Commit 6f22494d19b605ded308dc0fa713e91cb873f44a
"Move sctp to utils and bump it to 1.0.15"

introduced a build failure for the prefixed architectures.
We need to take into consideration the __USER_LABEL_PREFIX__
for architectures that define it when creating symbol aliases.

Fixes the build for the Meta(metag) architecture

[...]
utils/sctp/func_tests/test_connectx.c:151: undefined reference to `_sctp_connectx'
utils/sctp/func_tests/test_connectx.c:163: undefined reference to `_sctp_connectx'
[...]

Build tested on x86_64 and metag.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 utils/sctp/lib/connectx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/utils/sctp/lib/connectx.c b/utils/sctp/lib/connectx.c
index 50cf4c8..8e5a1f8 100644
--- a/utils/sctp/lib/connectx.c
+++ b/utils/sctp/lib/connectx.c
@@ -179,7 +179,10 @@ int sctp_connectx3(int fd, struct sockaddr *addrs, int addrcnt,
 	return __connectx(fd, addrs, addrs_size, id);
 }
 
-__asm__(".symver __sctp_connectx, sctp_connectx@");
-__asm__(".symver sctp_connectx_orig, sctp_connectx@VERS_1");
-__asm__(".symver sctp_connectx2, sctp_connectx@VERS_2");
-__asm__(".symver sctp_connectx3, sctp_connectx@@VERS_3");
+#define _STR(X) #X
+#define STR(X)  _STR(X)
+#define __UPREF STR(__USER_LABEL_PREFIX__)
+__asm__(".symver "__UPREF "__sctp_connectx," __UPREF "sctp_connectx@");
+__asm__(".symver "__UPREF "sctp_connectx_orig," __UPREF "sctp_connectx@VERS_1");
+__asm__(".symver "__UPREF "sctp_connectx2," __UPREF "sctp_connectx@VERS_2");
+__asm__(".symver "__UPREF "sctp_connectx3," __UPREF "sctp_connectx@@VERS_3");
-- 
1.8.5.1



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

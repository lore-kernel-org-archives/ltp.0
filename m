Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1VrRu1-0000yw-FB
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 12:31:33 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VrRu0-0006f6-6Z
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 12:31:33 +0000
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Fri, 13 Dec 2013 12:31:02 +0000
Message-ID: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed architectures
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

The following upstream patch (0600c8968cc2dea04cbf13ec739216e2939d08fe)
fixes the build for the Meta(metag) architecture

[...]
utils/sctp/func_tests/test_connectx.c:151: undefined reference to `_sctp_connectx'
utils/sctp/func_tests/test_connectx.c:163: undefined reference to `_sctp_connectx'
[...]

Build tested on x86_64 and metag.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Upstream:
https://github.com/borkmann/lksctp-tools/commit/0600c8968cc2dea04cbf13ec739216e2939d08fe
---
 utils/sctp/lib/connectx.c | 11 +++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

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
+#define __SYMPFX(pfx, sym) #pfx sym
+#define _SYMPFX(pfx, sym) __SYMPFX(pfx, sym)
+#define SYMPFX(sym) _SYMPFX(__USER_LABEL_PREFIX__, #sym)
+#define SYMVER(name, name2) __asm__(".symver " SYMPFX(name) "," SYMPFX(name2))
+
+SYMVER(__sctp_connectx, sctp_connectx@);
+SYMVER(sctp_connectx_orig, sctp_connectx@VERS_1);
+SYMVER(sctp_connectx2, sctp_connectx@VERS_2);
+SYMVER(sctp_connectx3, sctp_connectx@@VERS_3);
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

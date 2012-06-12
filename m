Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vlee@twitter.com>) id 1SeGIH-0000Pv-FJ
	for ltp-list@lists.sourceforge.net; Tue, 12 Jun 2012 01:53:17 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SeGIF-0005xQ-VS
	for ltp-list@lists.sourceforge.net; Tue, 12 Jun 2012 01:53:16 +0000
Received: by pbbrq2 with SMTP id rq2so73823pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Jun 2012 18:53:09 -0700 (PDT)
From: Vinson Lee <vlee@twitter.com>
Date: Mon, 11 Jun 2012 18:27:25 -0700
Message-Id: <1339464445-21694-1-git-send-email-vlee@twitter.com>
Subject: [LTP] [PATCH] filecaps: Fix build.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Fix build error that was introduced at commit
66ad27e08d774c572e99e97cc9b885295ec0aa55.

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/tmp/ltp/testcases/kernel/include -D_GNU_SOURCE -I../../../../include
-I../../../../include -L../../../../lib c.c -lltp -o c c.c:22:28: fatal
error: sys/capability.h: No such file or directory

Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 testcases/kernel/security/filecaps/c.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/security/filecaps/c.c b/testcases/kernel/security/filecaps/c.c
index 38c1516..fbd0365 100644
--- a/testcases/kernel/security/filecaps/c.c
+++ b/testcases/kernel/security/filecaps/c.c
@@ -19,7 +19,9 @@
 /******************************************************************************/
 
 #include <stdio.h>
+#if HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
+#endif
 
 int main()
 {
-- 
1.7.9.5


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

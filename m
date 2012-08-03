Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vlee@twitter.com>) id 1SxQN5-0007Di-HM
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 22:29:27 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SxQN4-00087R-W9
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 22:29:27 +0000
Received: by pbbrq2 with SMTP id rq2so1878719pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 03 Aug 2012 15:29:21 -0700 (PDT)
From: Vinson Lee <vlee@twitter.com>
Date: Fri,  3 Aug 2012 15:29:04 -0700
Message-Id: <1344032944-27019-1-git-send-email-vlee@twitter.com>
Subject: [LTP] [PATCH] ltp_signal.h: Remove inline keyword from handler_h.
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

This patch fixes this build error with clang.

testcases/kernel/syscalls/rt_sigaction/../../../../include/ltp_signal.h:85: undefined reference to `handler_h'

Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 include/ltp_signal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/ltp_signal.h b/include/ltp_signal.h
index 1ac6f70..093059f 100644
--- a/include/ltp_signal.h
+++ b/include/ltp_signal.h
@@ -69,7 +69,7 @@ struct kernel_sigaction {
 
 void (*restore_rt) (void);
 
-inline void
+void
 handler_h (int signal)
 {
 	return;
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

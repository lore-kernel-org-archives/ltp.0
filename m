Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nobuhiro@andestech.com>) id 1MGVPR-0002pl-H7
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 09:56:53 +0000
Received: from 59-124-160-117.hinet-ip.hinet.net ([59.124.160.117]
	helo=ATCPCS06.andestech.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGVMr-0006g2-71
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 09:56:53 +0000
From: nobuhiro <nobuhiro@andestech.com>
Date: Tue, 16 Jun 2009 17:45:38 +0800
Message-Id: <1245145538-25870-1-git-send-email-nobuhiro@andestech.com>
Subject: [LTP] [PATCH] mmapstress03: consider passed when returning EINVAL
	in the large mmap test.
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

Some architectures may return EINVAL instead of ENOMEM.
This should also be ok according to mmap manual:
EINVAL We don't like addr, length, or offset (e.g., they are too large, or not aligned on a page boundary).

Signed-off-by: nobuhiro <nobuhiro@andestech.com>
---
 testcases/kernel/mem/mmapstress/mmapstress03.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress03.c b/testcases/kernel/mem/mmapstress/mmapstress03.c
index 8b41959..3ce5540 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress03.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress03.c
@@ -166,8 +166,8 @@ main(int argc, char *argv[])
 		ERROR("really large mmap didn't fail");
                 anyfail();
 	}
-	if (errno != ENOMEM) {
-		ERROR("really large mmap didn't set errno = ENOMEM");
+	if (errno != ENOMEM && errno != EINVAL) {
+		ERROR("really large mmap didn't set errno = ENOMEM nor EINVAL");
                 anyfail();
 	}
 	(void)time(&t);
-- 
1.6.3


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

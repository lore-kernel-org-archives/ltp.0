Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nobuhiro@andestech.com>) id 1MHHBN-0001yx-0K
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 12:57:33 +0000
Received: from 59-124-160-117.hinet-ip.hinet.net ([59.124.160.117]
	helo=ATCPCS06.andestech.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHHBE-00052K-Ne
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 12:57:27 +0000
From: nobuhiro <nobuhiro@andestech.com>
Date: Thu, 18 Jun 2009 20:21:23 +0800
Message-Id: <1245327683-8493-1-git-send-email-nobuhiro@andestech.com>
Subject: [LTP] [PATCH] growfiles: fix static build which needs to link the
	pthread library
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


Signed-off-by: nobuhiro <nobuhiro@andestech.com>
---
 testcases/kernel/fs/doio/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/fs/doio/Makefile b/testcases/kernel/fs/doio/Makefile
index 4e0cd24..6e8f2de 100644
--- a/testcases/kernel/fs/doio/Makefile
+++ b/testcases/kernel/fs/doio/Makefile
@@ -1,6 +1,6 @@
 
 CFLAGS+= -Wall -I../../../../include -D_LARGEFILE64_SOURCE
-LDLIBS+= -L../../../../lib -lltp -lrt
+LDLIBS+= -L../../../../lib -lltp -lrt -lpthread
 
 TARGETS=doio growfiles rwtest iogen
 SRCS=$(wildcard *.c)
-- 
1.6.3.1


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

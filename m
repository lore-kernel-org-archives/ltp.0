Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nobuhiro@andestech.com>) id 1MTcrs-0001iQ-6F
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 14:32:28 +0000
Received: from 59-124-160-117.hinet-ip.hinet.net ([59.124.160.117]
	helo=ATCPCS06.andestech.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTcrl-00068C-N7
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 14:32:28 +0000
From: nobuhiro <nobuhiro@andestech.com>
Date: Wed, 22 Jul 2009 22:22:05 +0800
Message-Id: <1248272525-13205-1-git-send-email-nobuhiro@andestech.com>
Subject: [LTP] [PATCH] Fixed static build which needs to link the pthread
	library in pidns and pipeio.
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
 testcases/kernel/containers/pidns/Makefile |    2 +-
 testcases/kernel/ipc/pipeio/Makefile       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/pidns/Makefile b/testcases/kernel/containers/pidns/Makefile
index 4886d58..14f49da 100644
--- a/testcases/kernel/containers/pidns/Makefile
+++ b/testcases/kernel/containers/pidns/Makefile
@@ -20,7 +20,7 @@
 
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include -I../libclone
-LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt
+LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt -lpthread
 
 SRCS    := $(wildcard *.c)
 TARGETS := $(SRCS:%.c=%)
diff --git a/testcases/kernel/ipc/pipeio/Makefile b/testcases/kernel/ipc/pipeio/Makefile
index afd3e8d..d2a1d5f 100644
--- a/testcases/kernel/ipc/pipeio/Makefile
+++ b/testcases/kernel/ipc/pipeio/Makefile
@@ -22,7 +22,7 @@
 ###########################################################################
 CFLAGS   += -Wall
 CPPFLAGS += -I../../../../include
-LDLIBS   += -L../../../../lib -lltp -lrt
+LDLIBS   += -L../../../../lib -lltp -lrt -lpthread
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
-- 
1.6.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

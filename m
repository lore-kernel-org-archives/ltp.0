Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WpaJv-0008Je-62
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 09:38:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WpaJt-0002br-52
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 09:38:51 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4S9cg41024124
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 17:38:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 28 May 2014 17:36:14 +0800
Message-ID: <1401269774-7030-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases/kernel/include/lib.mk: fix invalid
	libkerntest.a path
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

In testcases/kernel/include/lib.mk, '$(KERNEL_DIR)/libkerntest.a' is not a
valid path, the correct path is '$(LIBKERNTEST_DIR)/libkerntest.a'.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/include/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
index c193ca3..f79a1c0 100644
--- a/testcases/kernel/include/lib.mk
+++ b/testcases/kernel/include/lib.mk
@@ -21,7 +21,7 @@ LIBKERNTEST_SRCDIR	:= $(KERNEL_SRCDIR)/lib
 
 KERNEL_DIR		:= $(abs_top_builddir)/testcases/kernel
 LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
-LIBKERNTEST		:= $(KERNEL_DIR)/libkerntest.a
+LIBKERNTEST		:= $(LIBKERNTEST_DIR)/libkerntest.a
 CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
 LDLIBS			+= $(NUMA_LIBS) -lkerntest -lltp
 LDFLAGS			+= -L$(LIBKERNTEST_DIR)
-- 
1.8.2.1


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

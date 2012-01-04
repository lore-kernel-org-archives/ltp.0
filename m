Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1RiGLY-0003TV-HC
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 02:12:56 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiGLX-000309-CB
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 02:12:56 +0000
From: Shang Yanfeng <YanFeng.Shang@windriver.com>
Date: Wed, 4 Jan 2012 10:12:44 +0800
Message-ID: <1325643164-15721-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] memory in mips with 32bit ELF is lower than 0x80000000
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
To: ltp-list@lists.sourceforge.net, vapierfilter@gmail.com

because userspace memory in mips with 32bit ELF is lower than 0x80000000, so mmap failed.

signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 45cddf7..1e59f1d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -64,8 +64,13 @@
 #include "usctest.h"
 #include "system_specific_hugepages_info.h"
 
-#define LOW_ADDR       (void *)(0x80000000)
-#define LOW_ADDR2      (void *)(0x90000000)
+#if defined(__mips__) && __WORDSIZE == 32
+#define LOW_ADDR (void *)(0x40000000)
+#define LOW_ADDR2 (void *)(0x50000000)
+#else
+#define LOW_ADDR (void *)(0x80000000)
+#define LOW_ADDR2 (void *)(0x90000000)
+#endif
 
 char TEMPFILE[MAXPATHLEN];
 
-- 
1.6.3.1


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

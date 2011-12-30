Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1RgW23-0001z4-R5
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 06:33:35 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RgW22-0002ms-Md
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 06:33:35 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBU6XQbs017944
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Dec 2011 22:33:26 -0800 (PST)
From: Shang Yanfeng <YanFeng.Shang@windriver.com>
Date: Fri, 30 Dec 2011 14:33:23 +0800
Message-ID: <1325226803-29578-1-git-send-email-YanFeng.Shang@windriver.com>
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
To: ltp-list@lists.sourceforge.net
Cc: Haotian.Zhang@windriver.com

because userspace memory in mips with 32bit ELF is lower than 0x80000000,
so mmap failed.

signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 45cddf7..279b12a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -64,8 +64,18 @@
 #include "usctest.h"
 #include "system_specific_hugepages_info.h"
 
+#if defined(__mips__)
+#if __WORDSIZE==32
+#define LOW_ADDR       (void *)(0x40000000)
+#define LOW_ADDR2      (void *)(0x50000000)
+#else
 #define LOW_ADDR       (void *)(0x80000000)
 #define LOW_ADDR2      (void *)(0x90000000)
+#endif
+#else
+#define LOW_ADDR       (void *)(0x80000000)
+#define LOW_ADDR2      (void *)(0x90000000)
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

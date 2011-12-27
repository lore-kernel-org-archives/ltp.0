Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1RfTrm-000485-W6
	for ltp-list@lists.sourceforge.net; Tue, 27 Dec 2011 10:02:42 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RfTrh-0008N1-1t
	for ltp-list@lists.sourceforge.net; Tue, 27 Dec 2011 10:02:42 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBRA2Vx0015718
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Dec 2011 02:02:31 -0800 (PST)
From: Shang Yanfeng <YanFeng.Shang@windriver.com>
Date: Tue, 27 Dec 2011 18:02:29 +0800
Message-ID: <1324980149-29612-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] hugeshmat01 isn't adapt to mips with 64bit ELF
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

Because userspace memory in mips with 64bit ELF is lower than 2^40,
so shmat failed.

signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>
---
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 6f270ce..67bd4b0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -67,7 +67,11 @@ unsigned long huge_pages_shm_to_be_allocated;
 #define CASE1		20		/* memory location.		   */
 
 #if __WORDSIZE==64
+#if defined(__mips__)
+#define UNALIGNED      0x1000000eee
+#else
 #define UNALIGNED      0x10000000eee
+#endif
 #else
 #define UNALIGNED      0x60000eee
 #endif
@@ -279,4 +283,4 @@ cleanup(void)
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
-- 
1.6.3.1


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZPi6I-0002st-Iu
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 02:18:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPi6H-0007y1-IR
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 02:18:38 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 555B18EA45
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Aug 2015 02:18:31 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t7D2IRlo027657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2015 22:18:30 -0400
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Aug 2015 10:18:26 +0800
Message-Id: <1439432306-2918-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] mem/thp: skip thp02/thp03 if system not support
	hugepage
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

Sometimes we get fails on system which not support hugepage:

thp02       1  TBROK  :  mem.c:1035: cannot find "Hugepagesize:" in /proc/meminfo
thp02       2  TBROK  :  mem.c:1035: Remaining cases broken

thp03       1  TBROK  :  mem.c:1035: cannot find "Hugepagesize:" in /proc/meminfo
thp03       2  TBROK  :  mem.c:1035: Remaining cases broken

Maybe skip the cases are better than TBROK them.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/thp/thp02.c | 3 +++
 testcases/kernel/mem/thp/thp03.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index 1470ae6..41d9192 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -121,6 +121,9 @@ static void do_mremap(void)
 
 void setup(void)
 {
+	if (access(PATH_THP, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "THP is not enabled");
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
index 8f62d0c..42f9025 100644
--- a/testcases/kernel/mem/thp/thp03.c
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -113,6 +113,9 @@ static void thp_test(void)
 
 void setup(void)
 {
+	if (access(PATH_THP, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "THP is not enabled");
+
 	hugepage_size = read_meminfo("Hugepagesize:") * KB;
 	unaligned_size = hugepage_size * 4 - 1;
 	page_size = SAFE_SYSCONF(NULL, _SC_PAGESIZE);
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

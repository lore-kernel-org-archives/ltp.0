Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WcWD5-0003cu-1S
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 08:37:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcWD1-0003JP-9K
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 08:37:46 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3M8bZcN032024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Apr 2014 04:37:35 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s3M8bUJu000843
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Apr 2014 04:37:34 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Apr 2014 10:37:20 +0200
Message-Id: <b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
In-Reply-To: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
References: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2] readahead02: read in 2M chunks
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

Max readahead size has been limited since commit:
  commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
  Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
  Date:   Thu Apr 3 14:48:23 2014 -0700
    mm/readahead.c: fix readahead failure for memoryless NUMA nodes
                    and limit readahead pages

Update testcase to read ahead in 2M chunks, this change is
compatible with older kernels.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 8940821..5b1524e 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -213,8 +213,13 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
 
 	if (do_readahead) {
-		TEST(ltp_syscall(__NR_readahead, fd, (off64_t) 0,
-			(size_t) fsize));
+		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
+		for (i = 0; i < fsize; i += 2*1024*1024) {
+			TEST(ltp_syscall(__NR_readahead, fd,
+				(off64_t) i, 2*1024*1024));
+			if (TEST_RETURN != 0)
+				break;
+		}
 		check_ret(0);
 		*cached = get_cached_size();
 
-- 
1.7.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

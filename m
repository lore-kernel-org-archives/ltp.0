Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SO2O0-0002ht-MF
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 07:48:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO2Nz-0002Fi-OQ
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 07:48:08 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Sat, 28 Apr 2012 15:48:41 +0800
Message-Id: <e83b4d425c1586a967531228804843d8bc3b391f.1335599279.git.zliu@redhat.com>
In-Reply-To: <66ac99257dc97775fbb2b44287874ad43d408b4c.1335599279.git.zliu@redhat.com>
References: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
	<66ac99257dc97775fbb2b44287874ad43d408b4c.1335599279.git.zliu@redhat.com>
In-Reply-To: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
References: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
Subject: [LTP] [PATCH 3/3] syscalls/move_pages: removed tst_exit in
	check_config()
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
To: LTP List <ltp-list@lists.sourceforge.net>

removed tst_exit in check_config(), as it's always involked
at any time, instead, using tst_brkm to displace tst_resm,
since TCONF should be called by tst_brkm.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages_support.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 6bd95d3..320486f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -382,14 +382,13 @@ void check_config(unsigned int min_nodes)
 {
 #if HAVE_NUMA_H && HAVE_NUMAIF_H
 	if (numa_available() < 0) {
-		tst_resm(TCONF, "NUMA support is not available");
+		tst_brkm(TCONF, NULL, "NUMA support is not available");
 	} else if (numa_max_node() < (min_nodes - 1)) {
-		tst_resm(TCONF, "atleast 2 NUMA nodes are required");
+		tst_brkm(TCONF, NULL, "atleast 2 NUMA nodes are required");
 	} else if (tst_kvercmp(2, 6, 18) < 0) {
-		tst_resm(TCONF, "2.6.18 or greater kernel required");
+		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
 	}
 #else
-	tst_resm(TCONF, "NUMA support not provided");
+	tst_brkm(TCONF, NULL, "NUMA support not provided");
 #endif
-	tst_exit();
 }
-- 
1.7.10


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

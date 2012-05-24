Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SXZHT-0003bQ-EZ
	for ltp-list@lists.sourceforge.net; Thu, 24 May 2012 14:44:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXZHN-0004Em-OT
	for ltp-list@lists.sourceforge.net; Thu, 24 May 2012 14:44:47 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4OEiZqM027724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 24 May 2012 10:44:35 -0400
Message-ID: <4FBE4951.20107@redhat.com>
Date: Thu, 24 May 2012 16:44:33 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030100050102060004000404"
Subject: [LTP] [PATCH v2] mbind01, get_mempolicy01: dont use hardcoded node 0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------030100050102060004000404
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


These tests are failing on following setup:
  # numactl -H
  available: 2 nodes (0-1)
  node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
  23 24 25 26 27 28 29 30 31
  node 0 size: 0 MB
  node 0 free: 0 MB
  node 1 cpus:
  node 1 size: 12288 MB
  node 1 free: 9998 MB
  node distances:
  node   0   1
    0:  10  40
    1:  40  10

Avoid hardcoded node 0 by picking first available node obtained using
get_mempolicy(..., MPOL_F_MEMS_ALLOWED);

Using whole nodemask doesn't work with MPOL_PREFERRED, because set_mempolicy
will use only first node and subsequent check for bitmask equality may fail.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   19 +++++++++++++++++--
 testcases/kernel/syscalls/mbind/mbind01.c          |   19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)



--------------030100050102060004000404
Content-Type: text/x-patch;
	name="0001-mbind01-get_mempolicy01-dont-use-hardcoded-node-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-mbind01-get_mempolicy01-dont-use-hardcoded-node-0.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 0565d6f..8069df1 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -231,15 +231,30 @@ static int do_test(struct test_case *tc)
 #endif
 	char *p = NULL;
 	unsigned long len = MEM_LENGTH;
+	struct bitmask *allowed = NULL;
+	int i, test_node = -1;
+
+	allowed = numa_allocate_nodemask();
+	// avoid numa_get_mems_allowed(), because of bug in getpol() utility function
+	// in older versions: http://www.spinics.net/lists/linux-numa/msg00849.html
+	TEST(syscall(__NR_get_mempolicy, NULL, allowed->maskp,
+		allowed->size, 0, MPOL_F_MEMS_ALLOWED));
+	if (TEST_RETURN < 0)
+		tst_resm(TFAIL|TERRNO, "get_mempolicy: MPOL_F_MEMS_ALLOWED");
+	for (i = 0; i < allowed->size; i++)
+		if (numa_bitmask_isbitset(allowed, i)) {
+			test_node = i;
+			break;
+		}
 
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	nodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(nodemask);
-	nodemask_set(nodemask, 0);
+	nodemask_set(nodemask, test_node);
 	getnodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(getnodemask);
 #else
-	numa_bitmask_setbit(nodemask, 0);
+	numa_bitmask_setbit(nodemask, test_node);
 #endif
 	switch (tc->ttype) {
 	case DEFAULT:
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 4b25db0..c3170ec 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -217,15 +217,30 @@ static int do_test(struct test_case *tc)
 	unsigned long maxnode = NUMA_NUM_NODES;
 	unsigned long len = MEM_LENGTH;
 	unsigned long *invalid_nodemask;
+	struct bitmask *allowed = NULL;
+	int i, test_node = -1;
+
+	allowed = numa_allocate_nodemask();
+	// avoid numa_get_mems_allowed(), because of bug in getpol() utility function
+	// in older versions: http://www.spinics.net/lists/linux-numa/msg00849.html
+	TEST(syscall(__NR_get_mempolicy, NULL, allowed->maskp,
+		allowed->size, 0, MPOL_F_MEMS_ALLOWED));
+	if (TEST_RETURN < 0)
+		tst_resm(TFAIL|TERRNO, "get_mempolicy: MPOL_F_MEMS_ALLOWED");
+	for (i = 0; i < allowed->size; i++)
+		if (numa_bitmask_isbitset(allowed, i)) {
+			test_node = i;
+			break;
+		}
 
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	nodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(nodemask);
-	nodemask_set(nodemask, 0);
+	nodemask_set(nodemask, test_node);
 	getnodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(getnodemask);
 #else
-	numa_bitmask_setbit(nodemask, 0);
+	numa_bitmask_setbit(nodemask, test_node);
 #endif
 	p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
 		    0, 0);


--------------030100050102060004000404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------030100050102060004000404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030100050102060004000404--


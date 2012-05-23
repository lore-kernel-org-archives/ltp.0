Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SX9LR-0002a3-42
	for ltp-list@lists.sourceforge.net; Wed, 23 May 2012 11:03:09 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SX9LN-0005gC-0K
	for ltp-list@lists.sourceforge.net; Wed, 23 May 2012 11:03:09 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4NB2xJJ008525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 23 May 2012 07:02:59 -0400
Message-ID: <4FBCC3E1.70302@redhat.com>
Date: Wed, 23 May 2012 13:02:57 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030506000309070609050103"
Subject: [LTP] [PATCH] mbind01, get_mempolicy01: dont use hardcoded node 0
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
--------------030506000309070609050103
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

Avoid hardcoded node 0 by using numa_get_mems_allowed().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |    7 ++++---
 testcases/kernel/syscalls/mbind/mbind01.c          |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)



--------------030506000309070609050103
Content-Type: text/x-patch;
	name="0001-mbind01-get_mempolicy01-dont-use-hardcoded-node-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-mbind01-get_mempolicy01-dont-use-hardcoded-node-0.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 0565d6f..12dc8d3 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -226,20 +226,21 @@ static int do_test(struct test_case *tc)
 	nodemask_t *nodemask, *getnodemask;
 	unsigned long maxnode = NUMA_NUM_NODES;
 #else
-	struct bitmask *nodemask = numa_allocate_nodemask();
+	struct bitmask *nodemask = NULL;
 	struct bitmask *getnodemask = numa_allocate_nodemask();
 #endif
 	char *p = NULL;
 	unsigned long len = MEM_LENGTH;
 
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	struct bitmask *allowed = numa_get_mems_allowed();
 	nodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(nodemask);
-	nodemask_set(nodemask, 0);
+	copy_bitmask_to_nodemask(allowed, nodemask);
 	getnodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(getnodemask);
 #else
-	numa_bitmask_setbit(nodemask, 0);
+	nodemask = numa_get_mems_allowed();
 #endif
 	switch (tc->ttype) {
 	case DEFAULT:
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 4b25db0..48066db 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -211,7 +211,7 @@ static int do_test(struct test_case *tc)
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	nodemask_t *nodemask, *getnodemask;
 #else
-	struct bitmask *nodemask = numa_allocate_nodemask();
+	struct bitmask *nodemask = NULL;
 	struct bitmask *getnodemask = numa_allocate_nodemask();
 #endif
 	unsigned long maxnode = NUMA_NUM_NODES;
@@ -219,13 +219,14 @@ static int do_test(struct test_case *tc)
 	unsigned long *invalid_nodemask;
 
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	struct bitmask *allowed = numa_get_mems_allowed();
 	nodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(nodemask);
-	nodemask_set(nodemask, 0);
+	copy_bitmask_to_nodemask(allowed, nodemask);
 	getnodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(getnodemask);
 #else
-	numa_bitmask_setbit(nodemask, 0);
+	nodemask = numa_get_mems_allowed();
 #endif
 	p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
 		    0, 0);


--------------030506000309070609050103
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
--------------030506000309070609050103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030506000309070609050103--


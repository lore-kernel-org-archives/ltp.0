Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1T6hhk-0007HN-O7
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 12:49:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6hhg-0006FA-Vd
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 12:49:08 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7TCmxDn004784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 29 Aug 2012 08:48:59 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Wed, 29 Aug 2012 20:43:48 +0800
Message-Id: <06b56f221ddc8215d3a0fe2690731596c48ca326.1346244062.git.zliu@redhat.com>
In-Reply-To: <cd572cfe7fb9a357ce92149957ed2a3779c542d3.1346244062.git.zliu@redhat.com>
References: <cd572cfe7fb9a357ce92149957ed2a3779c542d3.1346244062.git.zliu@redhat.com>
Subject: [LTP]  [PATCH 2/3] tunable/min_free_kbytes: remove map_count args
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
To: LTP list <ltp-list@lists.sourceforge.net>

as the type of total_mem is 'unsigned long', inside
32-bit system, it will overflow in this sentence
  map_count = total_mem * KB / MAP_SIZE

e.g: if total_mem > 4194304, 'total_mem*KB' will > ULONG_MAX.

after re-cehck the code, I found map_count was not necessary,
and removing it can fix the overflow issue.

Reported-by: Shuang Qiu <shuang.qiu@oracle.com>
Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index f8288ec..dde182c 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -177,31 +177,23 @@ static void test_tune(unsigned long overcommit_policy)
 
 static int eatup_mem(unsigned long overcommit_policy)
 {
-	int map_count, i;
 	int ret = 0;
 	unsigned long memfree;
-	void **addrs;
-
-	map_count = total_mem * KB / MAP_SIZE;
-	addrs = (void **)malloc(map_count * sizeof(void *));
-	if (addrs == NULL) {
-		perror("malloc");
-		return -1;
-	}
+	void *addrs;
 
 	memfree = read_meminfo("MemFree:");
 	printf("memfree is %lu kB before eatup mem\n", memfree);
-	for (i = 0; i < map_count; i++) {
-		addrs[i] = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
+	while (1) {
+		addrs = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
 		    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-		if (addrs[i] == MAP_FAILED) {
+		if (addrs == MAP_FAILED) {
 			if (overcommit_policy != 1 && errno != ENOMEM) {
 				perror("mmap");
 				ret = -1;
 			}
 			break;
 		}
-		memset(addrs[i], i, MAP_SIZE);
+		memset(addrs, 1, MAP_SIZE);
 	}
 	memfree = read_meminfo("MemFree:");
 	printf("memfree is %lu kB after eatup mem\n", memfree);
-- 
1.7.11.2


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

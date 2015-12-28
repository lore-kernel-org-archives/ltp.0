Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1aDS7z-0002y4-HJ
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2015 07:21:59 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aDS7y-0000EP-Ce
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2015 07:21:59 +0000
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 28 Dec 2015 00:21:52 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
	(b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 355D419D803E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Dec 2015 00:09:54 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id tBS7Logp26804390
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2015 00:21:50 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id tBS7LodG019125
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2015 00:21:50 -0700
Received: from localhost.localdomain ([9.83.18.123])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	tBS7Lnmp019095
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2015 00:21:50 -0700
Date: Mon, 28 Dec 2015 15:20:43 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20151228072043.GA11687@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from
	oom()
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

Looks like there is no such a case "OVERCOMMIT" in oom(), so we can just
remove it.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/mem/include/mem.h | 7 +++----
 testcases/kernel/mem/lib/mem.c     | 2 +-
 testcases/kernel/mem/oom/oom01.c   | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 4a18799..041c437 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -32,10 +32,9 @@ static inline void clean_node(unsigned long *array)
 
 #define LENGTH			(3UL<<30)
 #define TESTMEM			(1UL<<30)
-#define OVERCOMMIT		1
-#define NORMAL			2
-#define MLOCK			3
-#define KSM			4
+#define NORMAL			1
+#define MLOCK			2
+#define KSM			3
 
 long overcommit;
 void oom(int testcase, int lite, int retcode, int allow_sigkill);
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index cee4e91..56104cb 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -110,7 +110,7 @@ out:
  * oom - allocates memory according to specified testcase and checks
  *       desired outcome (e.g. child killed, operation failed with ENOMEM)
  * @testcase: selects how child allocates memory
- *            valid choices are: OVERCOMMIT, NORMAL, MLOCK and KSM
+ *            valid choices are: NORMAL, MLOCK and KSM
  * @lite: if non-zero, child makes only single TESTMEM+MB allocation
  *        if zero, child keeps allocating memory until it gets killed
  *        or some operation fails
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 712d7b5..e39394b 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -58,12 +58,12 @@ int main(int argc, char *argv[])
 
 		/* we expect mmap to fail before OOM is hit */
 		set_sys_tune("overcommit_memory", 2, 1);
-		oom(OVERCOMMIT, 0, ENOMEM, 0);
+		oom(NORMAL, 0, ENOMEM, 0);
 
 		/* with overcommit_memory set to 0 or 1 there's no
 		 * guarantee that mmap fails before OOM */
 		set_sys_tune("overcommit_memory", 0, 1);
-		oom(OVERCOMMIT, 0, ENOMEM, 1);
+		oom(NORMAL, 0, ENOMEM, 1);
 
 		set_sys_tune("overcommit_memory", 1, 1);
 		testoom(0, 0, ENOMEM, 1);
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

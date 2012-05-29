Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SZHpb-0008Ql-Fx
	for ltp-list@lists.sourceforge.net; Tue, 29 May 2012 08:31:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZHpV-00074h-Qf
	for ltp-list@lists.sourceforge.net; Tue, 29 May 2012 08:31:07 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4T8UuVg032395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 May 2012 04:30:56 -0400
Message-ID: <4FC4893E.6090001@redhat.com>
Date: Tue, 29 May 2012 10:30:54 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040806000600080002070405"
Subject: [LTP] [PATCH v2 4/4] move_pages: dont use hardcoded NUMA node ids
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
--------------040806000600080002070405
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/move_pages/Makefile      |    5 +-
 .../kernel/syscalls/move_pages/move_pages02.c      |   11 +++--
 .../kernel/syscalls/move_pages/move_pages03.c      |   11 +++--
 .../kernel/syscalls/move_pages/move_pages04.c      |   11 +++--
 .../kernel/syscalls/move_pages/move_pages05.c      |   11 +++--
 .../kernel/syscalls/move_pages/move_pages06.c      |    9 +++-
 .../kernel/syscalls/move_pages/move_pages07.c      |   11 +++--
 .../kernel/syscalls/move_pages/move_pages08.c      |    9 +++-
 .../kernel/syscalls/move_pages/move_pages09.c      |    7 ++-
 .../kernel/syscalls/move_pages/move_pages10.c      |   11 +++--
 .../kernel/syscalls/move_pages/move_pages11.c      |   11 +++--
 .../syscalls/move_pages/move_pages_support.c       |   44 ++++++++++++++-----
 .../syscalls/move_pages/move_pages_support.h       |    1 +
 13 files changed, 101 insertions(+), 51 deletions(-)



--------------040806000600080002070405
Content-Type: text/x-patch;
	name="0004-move_pages-dont-use-hardcoded-NUMA-node-ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0004-move_pages-dont-use-hardcoded-NUMA-node-ids.patch"

diff --git a/testcases/kernel/syscalls/move_pages/Makefile b/testcases/kernel/syscalls/move_pages/Makefile
index d233378..cf2b83f 100644
--- a/testcases/kernel/syscalls/move_pages/Makefile
+++ b/testcases/kernel/syscalls/move_pages/Makefile
@@ -22,8 +22,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -I$(abs_srcdir)/../utils
 
-LDLIBS			+= $(NUMA_LIBS)
-
 INSTALL_TARGETS		:= move_pages.sh
 
 MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))
@@ -35,6 +33,7 @@ move_pages_support.o: CFLAGS += -Wno-unused-function
 
 $(MAKE_TARGETS): %: %.o move_pages_support.o
 
-LDLIBS			+= $(NUMA_LIBS) -lpthread -lrt
+LDLIBS			+= -lpthread -lrt
 
+include $(abs_srcdir)/../numa/Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index cd0e914..410e368 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -83,15 +83,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
@@ -156,4 +159,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index 791835b..77de94d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -122,15 +122,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 		pid_t cpid;
 		sem_t *sem;
 
@@ -223,4 +226,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 4de116b..acb4c78 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -89,15 +89,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 		unsigned long onepage = get_page_size();
 
 		/* reset Tst_count in case we are looping */
@@ -175,4 +178,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 6b2334b..d2db475 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -123,15 +123,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[N_TEST_PAGES] = { 0 };
 		int nodes[N_TEST_PAGES];
 		int status[N_TEST_PAGES];
-		int ret;
 		pid_t cpid;
 		sem_t *sem;
 
@@ -237,4 +240,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 16e8206..6929f8d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -83,15 +83,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
+	unsigned int from_node;
 	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(1, &from_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
@@ -152,4 +155,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index 2d2b1d8..4a1f96a 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -83,15 +83,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 		int ipid;
 
 		/* reset Tst_count in case we are looping */
@@ -163,4 +166,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 44c9acc..9b36a00 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -81,15 +81,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 3a626e8..8190a26 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -81,14 +81,17 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
+	unsigned int from_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(1, &from_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index 7af861b..cec114c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -83,15 +83,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
@@ -151,4 +154,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 747b9f0..3d82c6f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -122,15 +122,18 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int ret;
+
+	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ret;
 		pid_t cpid;
 		sem_t *sem;
 
@@ -241,4 +244,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 320486f..f7e3995 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -97,6 +97,7 @@ int alloc_pages_on_nodes(void **pages, unsigned int num, int *nodes)
 	return -1;
 }
 
+
 /*
  * alloc_pages_linear() - allocate pages in each NUMA node
  * @pages: array in which the page pointers will be stored
@@ -114,16 +115,22 @@ int alloc_pages_linear(void **pages, unsigned int num)
 
 #if HAVE_NUMA_H
 	unsigned int i;
-	unsigned int n;
+	unsigned int n = 0;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+	int ret;
 
-	n = 0;
-	for (i = 0; i < num; i++) {
-		nodes[i] = n;
+	ret = get_allowed_nodes_arr(&num_allowed_nodes, &allowed_nodes);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
 
+	for (i = 0; i < num; i++) {
+		nodes[i] = allowed_nodes[n];
 		n++;
-		if (n > numa_max_node())
+		if (n >= num_allowed_nodes)
 			n = 0;
 	}
+	free(allowed_nodes);
 #endif
 
 	return alloc_pages_on_nodes(pages, num, nodes);
@@ -210,18 +217,23 @@ void verify_pages_linear(void **pages, int *status, unsigned int num)
 {
 #if HAVE_NUMA_H
 	unsigned int i;
-	unsigned int n;
+	unsigned int n = 0;
 	int nodes[num];
+	int num_allowed_nodes;
+	int *allowed_nodes;
+	int ret;
 
-	n = 0;
+	ret = get_allowed_nodes_arr(&num_allowed_nodes, &allowed_nodes);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
 
 	for (i = 0; i < num; i++) {
-		nodes[i] = i;
-
+		nodes[i] = allowed_nodes[n];
 		n++;
-		if (n > numa_max_node())
+		if (n >= num_allowed_nodes)
 			n = 0;
 	}
+	free(allowed_nodes);
 
 	verify_pages_on_nodes(pages, status, num, nodes);
 #endif
@@ -381,10 +393,18 @@ void free_sem(sem_t * sem, int num)
 void check_config(unsigned int min_nodes)
 {
 #if HAVE_NUMA_H && HAVE_NUMAIF_H
+	int num_allowed_nodes;
+	int ret;
+
+	ret = get_allowed_nodes_arr(&num_allowed_nodes, NULL);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
+
 	if (numa_available() < 0) {
 		tst_brkm(TCONF, NULL, "NUMA support is not available");
-	} else if (numa_max_node() < (min_nodes - 1)) {
-		tst_brkm(TCONF, NULL, "atleast 2 NUMA nodes are required");
+	} else if (num_allowed_nodes < min_nodes) {
+		tst_brkm(TCONF, NULL, "at least %d allowed NUMA nodes"
+		    " are required", min_nodes);
 	} else if (tst_kvercmp(2, 6, 18) < 0) {
 		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
 	}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.h b/testcases/kernel/syscalls/move_pages/move_pages_support.h
index fd78572..bb8f636 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.h
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.h
@@ -27,6 +27,7 @@
 #include <numaif.h>
 #endif
 #include <semaphore.h>
+#include "numa_helper.h"
 
 long get_page_size();
 


--------------040806000600080002070405
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
--------------040806000600080002070405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040806000600080002070405--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sw2eV-0004sS-1h
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 02:57:43 +0000
Received: from mail-gh0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sw2eU-0007X4-4S
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 02:57:43 +0000
Received: by ghbz2 with SMTP id z2so5566453ghb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jul 2012 19:57:36 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 31 Jul 2012 10:57:19 +0800
Message-Id: <ba9ec47929d3aa8783905c1e9061536e515ca9f6.1343703433.git.caspar@casparzhang.com>
In-Reply-To: <35d6826c595733530915a3467146b9532f427429.1343703433.git.caspar@casparzhang.com>
References: <35d6826c595733530915a3467146b9532f427429.1343703433.git.caspar@casparzhang.com>
In-Reply-To: <35d6826c595733530915a3467146b9532f427429.1343703433.git.caspar@casparzhang.com>
References: <35d6826c595733530915a3467146b9532f427429.1343703433.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch makes the tests in mem/ dir use numa_helper in libkerntest.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/cpuset/Makefile           |    1 +
 testcases/kernel/mem/cpuset/cpuset01.c         |   16 +++---
 testcases/kernel/mem/hugetlb/Makefile.inc      |    1 +
 testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 +
 testcases/kernel/mem/include/mem.h             |    2 +-
 testcases/kernel/mem/ksm/Makefile              |    1 +
 testcases/kernel/mem/ksm/ksm02.c               |    9 ++--
 testcases/kernel/mem/ksm/ksm04.c               |    9 ++--
 testcases/kernel/mem/lib/Makefile              |    1 +
 testcases/kernel/mem/lib/mem.c                 |   61 +++++++++++++++++------
 testcases/kernel/mem/oom/Makefile              |    1 +
 testcases/kernel/mem/oom/oom02.c               |    4 --
 testcases/kernel/mem/oom/oom04.c               |    4 --
 testcases/kernel/mem/swapping/Makefile         |    1 +
 testcases/kernel/mem/thp/Makefile              |    1 +
 testcases/kernel/mem/tunable/Makefile          |    1 +
 16 files changed, 71 insertions(+), 43 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch; name="0002-mm-use-new-numa_helper.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-mm-use-new-numa_helper.patch"

diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index f0c34ba..c9d03bf 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -41,4 +41,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index b20485f..d3770e5 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -51,6 +51,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "mem.h"
+#include "numa_helper.h"
 
 char *TCID = "cpuset01";
 int TST_TOTAL = 1;
@@ -58,8 +59,8 @@ int TST_TOTAL = 1;
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 volatile int end;
-static long nodes[MAXNODES];
-static long nnodes;
+static int *nodes;
+static int nnodes;
 static long ncpus;
 
 static void testcpuset(void);
@@ -77,11 +78,10 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	ncpus = count_cpu();
-	nnodes = count_numa(nodes);
-	tst_resm(TINFO, "The system has %ld CPUs, %ld NUMA nodes",
-			ncpus, nnodes);
+	if (get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &nnodes, &nodes) < 0)
+		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes_arr");
 	if (nnodes <= 1)
-		tst_brkm(TCONF, NULL, "required a NUMA system.");
+		tst_brkm(TCONF, NULL, "require a NUMA system.");
 
 	setup();
 	testcpuset();
@@ -115,9 +115,9 @@ static void testcpuset(void)
 	}
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
-		snprintf(buf, BUFSIZ, "%ld", nodes[0]);
+		snprintf(buf, BUFSIZ, "%d", nodes[0]);
 		write_cpuset_files(CPATH_NEW, "mems", buf);
-		snprintf(buf, BUFSIZ, "%ld", nodes[1]);
+		snprintf(buf, BUFSIZ, "%d", nodes[1]);
 		write_cpuset_files(CPATH_NEW, "mems", buf);
 	}
 
diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
index c7073a5..1831fbb 100644
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ b/testcases/kernel/mem/hugetlb/Makefile.inc
@@ -41,4 +41,5 @@ MAKE_DEPS		+= $(LIBMEM) $(LIBIPC)
 lib-clean:: $(LIBMEMDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 # vim: syntax=make
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 15ae693..0b1b60c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -34,4 +34,5 @@ LDFLAGS			+= -L$(abs_builddir)/$(LIBMEMDIR)
 LDLIBS			+= $(NUMA_LIBS) -lmem -lltp
 MAKE_DEPS		+= $(LIBMEM)
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index cdc326b..610c936 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -67,7 +67,7 @@ void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
 void umount_mem(char *path, char *path_new);
 
 /* shared */
-long count_numa(long nodes[]);
+unsigned get_a_numa_node(void (*cleanup_fn)(void));
 int  path_exist(const char *path, ...);
 long read_meminfo(char *item);
 void set_sys_tune(char *sys_file, long tune, int check);
diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index c8e064c..b17845b 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -40,4 +40,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 92f1493..8e86c0e 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -88,14 +88,14 @@ int main(int argc, char *argv[])
 	char *msg;
 	int size = 128, num = 3, unit = 1;
 	unsigned long nmask = 0;
-	long nodes[MAXNODES];
+	unsigned node;
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	if (count_numa(nodes) <= 1)
-		tst_brkm(TCONF, NULL, "required a NUMA system.");
+	node  = get_a_numa_node(tst_exit);
+	nmask = 1 << node;
 
 	setup();
 
@@ -103,7 +103,6 @@ int main(int argc, char *argv[])
 		Tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 
-		nmask = 1 << nodes[1];
 		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
 			if (errno != ENOSYS)
 				tst_brkm(TBROK|TERRNO, cleanup,
@@ -115,7 +114,7 @@ int main(int argc, char *argv[])
 		}
 		create_same_memory(size, num, unit);
 
-		write_cpusets(nodes[1]);
+		write_cpusets(node);
 		create_same_memory(size, num, unit);
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 8a31051..3f2b645 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -88,14 +88,14 @@ int main(int argc, char *argv[])
 	char *msg;
 	int size = 128, num = 3, unit = 1;
 	unsigned long nmask = 0;
-	long nodes[MAXNODES];
+	unsigned node;
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	if (count_numa(nodes) <= 1)
-		tst_brkm(TCONF, NULL, "required a NUMA system.");
+	node  = get_a_numa_node(tst_exit);
+	nmask = 1 << node;
 
 	setup();
 
@@ -105,7 +105,6 @@ int main(int argc, char *argv[])
 
 		write_memcg();
 
-		nmask = 1 << nodes[1];
 		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
 			if (errno != ENOSYS)
 				tst_brkm(TBROK|TERRNO, cleanup,
@@ -117,7 +116,7 @@ int main(int argc, char *argv[])
 		}
 		create_same_memory(size, num, unit);
 
-		write_cpusets(nodes[1]);
+		write_cpusets(node);
 		create_same_memory(size, num, unit);
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib/Makefile
index b22b1dd..399e290 100644
--- a/testcases/kernel/mem/lib/Makefile
+++ b/testcases/kernel/mem/lib/Makefile
@@ -23,4 +23,5 @@ include $(top_srcdir)/include/mk/env_pre.mk
 CFLAGS			:= -I../include
 LIB			:= libmem.a
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 81410d8..078052e 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -22,6 +22,7 @@
 #include "safe_macros.h"
 #include "_private.h"
 #include "mem.h"
+#include "numa_helper.h"
 
 /* OOM */
 
@@ -67,7 +68,10 @@ void oom(int testcase, int mempolicy, int lite)
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask = 0;
-	long nodes[MAXNODES];
+	unsigned node;
+
+	node = get_a_numa_node(cleanup);
+	nmask += 1 << node;
 #endif
 
 	switch (pid = fork()) {
@@ -76,8 +80,6 @@ void oom(int testcase, int mempolicy, int lite)
 	case 0:
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
-		count_numa(nodes);
-		nmask += 1 << nodes[1];
 		if (mempolicy)
 			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
 				tst_brkm(TBROK|TERRNO, cleanup,
@@ -107,12 +109,8 @@ void testoom(int mempolicy, int lite, int numa)
 {
 	long nodes[MAXNODES];
 
-	if (numa && !mempolicy) {
-		if (count_numa(nodes) <= 1)
-			tst_brkm(TCONF, cleanup, "required a NUMA system.");
-		/* write cpusets to 2nd node */
-		write_cpusets(nodes[1]);
-	}
+	if (numa && !mempolicy)
+		write_cpusets(get_a_numa_node(cleanup));
 
 	tst_resm(TINFO, "start normal OOM testing.");
 	oom(NORMAL, mempolicy, lite);
@@ -715,16 +713,47 @@ void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
 
 /* shared */
 
-long count_numa(long nodes[])
+/* Warning: *DO NOT* use this function in child */
+unsigned get_a_numa_node(void (*cleanup_fn)(void))
 {
-	long nnodes, i;
+	unsigned nd1, nd2;
+	int ret;
 
-	nnodes = 0;
-	for (i = 0; i <= MAXNODES; i++)
-		if (path_exist(PATH_SYS_SYSTEM "/node/node%d", i))
-			nodes[nnodes++] = i;
+	ret = get_allowed_nodes(0, 2, &nd1, &nd2);
+	switch (ret) {
+	case 0:
+		break;
+	case -3:
+		tst_brkm(TCONF, cleanup_fn, "require a NUMA system.");
+	default:
+		tst_brkm(TBROK|TERRNO, cleanup_fn, "1st get_allowed_nodes");
+	}
 
-	return nnodes;
+	ret = get_allowed_nodes(NH_MEMS|NH_CPUS, 2, &nd1, &nd2);
+	switch (ret) {
+	case 0:
+		tst_resm(TINFO, "get node%lu.", nd2);
+		return nd2;
+	case -3:
+		/*
+		 * for unbalanced NUMA systems, at least 1 available node is
+		 * required.
+		 */
+		ret = get_allowed_nodes(NH_MEMS|NH_CPUS, 1, &nd1);
+		switch (ret) {
+		case 0:
+			tst_resm(TINFO, "get node%lu.", nd1);
+			return nd1;
+		case -3:
+			tst_brkm(TCONF, cleanup_fn, "require a NUMA system "
+				    "that has at least one node with both "
+				    "memory and cpu available.");
+		default:
+			tst_brkm(TBROK|TERRNO, cleanup_fn,
+				    "3rd get_allowed_nodes");
+		}
+	}
+	tst_brkm(TBROK|TERRNO, cleanup_fn, "2nd get_allowed_nodes");
 }
 
 int path_exist(const char *path, ...)
diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
index c8e064c..b17845b 100644
--- a/testcases/kernel/mem/oom/Makefile
+++ b/testcases/kernel/mem/oom/Makefile
@@ -40,4 +40,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 551aad5..f0e784f 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -48,7 +48,6 @@ int main(int argc, char *argv[])
 {
 	char *msg;
 	int lc;
-	long nodes[MAXNODES];
 
 	msg = parse_opts(argc, argv, NULL, NULL);
 	if (msg != NULL)
@@ -58,9 +57,6 @@ int main(int argc, char *argv[])
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
-	if (count_numa(nodes) <= 1)
-		tst_brkm(TCONF, NULL, "required a NUMA system.");
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 4b15b2f..15ba660 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -49,7 +49,6 @@ int main(int argc, char *argv[])
 	char *msg;
 	int lc;
 	int swap_acc_on = 1;
-	long nodes[MAXNODES];
 	char buf[BUFSIZ], mem[BUFSIZ];
 
 	msg = parse_opts(argc, argv, NULL, NULL);
@@ -60,9 +59,6 @@ int main(int argc, char *argv[])
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
-	if (count_numa(nodes) <= 1)
-		tst_brkm(TCONF, NULL, "required a NUMA system.");
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/mem/swapping/Makefile b/testcases/kernel/mem/swapping/Makefile
index c8e064c..b17845b 100644
--- a/testcases/kernel/mem/swapping/Makefile
+++ b/testcases/kernel/mem/swapping/Makefile
@@ -40,4 +40,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index 9eb197e..3ef9288 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -41,4 +41,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/tunable/Makefile b/testcases/kernel/mem/tunable/Makefile
index 9eb197e..3ef9288 100644
--- a/testcases/kernel/mem/tunable/Makefile
+++ b/testcases/kernel/mem/tunable/Makefile
@@ -41,4 +41,5 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
 	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
 
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--------------1.7.8.6
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
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



